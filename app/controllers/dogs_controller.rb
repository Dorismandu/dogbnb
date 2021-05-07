class DogsController < ApplicationController
  before_action :set_dog, only: [:show]
  skip_before_action :authenticate_user!, only: [:index, :show]
  def index
    if params[:query].present?
      sql_query = "breed ILIKE :query OR address ILIKE :query"
      @dogs = policy_scope(Dog).where(sql_query, query: "%#{params[:query]}%")
    else
      @dogs = policy_scope(Dog).order(created_at: :desc)
    end

    @markers = @dogs.geocoded.map do |dog|
      {
        lat: dog.latitude,
        lng: dog.longitude,
        infoWindow: { content: render_to_string(partial: "/dogs/map_box", locals: { dog: dog }) }
      }
    end
  end

  def show
    @booking = Booking.new
    @marker =  {
      lat: @dog.latitude,
      lng: @dog.longitude
    }
    authorize @booking

    @reviews = []
    @dog.bookings.each { |booking| @reviews << booking.review }
  end

  def new
    @dog = Dog.new
    all_dogs = Dog.all

    @dogs = all_dogs.select{ |dog| dog.user == current_user}

    requests = []

    @dogs.each do |dog|
      dog.bookings.each { | booking| requests << booking }
    end

    @pending_requests = requests.select { |request| request.status == 0 }
    @answered_requests =  requests.select { |request| request.status != 0 }

    authorize @dog
  end

  def create
    @dog = Dog.new(dog_params)
    authorize @dog
    @dog.user = current_user
    if @dog.save
      redirect_to dog_path(@dog)
    else
      render :new
    end
  end


  private

  def set_dog
    @dog = Dog.find(params[:id])
    authorize @dog
  end

  def dog_params
    params.require(:dog).permit(:name, :breed, :age, :description, :address, photos: [])
  end

end
