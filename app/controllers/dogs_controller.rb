class DogsController < ApplicationController
  before_action :set_dog, only: [:show]
  skip_before_action :authenticate_user!, only: [:index, :show]
  def index
    @dogs = policy_scope(Dog).order(created_at: :desc)
  end

  def show
    #@dog = Dog.find(params[:id])
    @booking = Booking.new
    authorize @booking
    
  end

  def new
    @dog = Dog.new
    all_dogs = Dog.all
    @dogs = all_dogs.select{ |dog| dog.user == current_user}
  
    @requests = []

    @dogs.each do |dog| 
      dog.bookings.each { | booking| @requests << booking }
    end

    authorize @dog
  end

  def create
    @dog = Dog.new(dog_params)
    authorize @dog
    @dog.user = current_user
    if  @dog.save
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
    params.require(:dog).permit(:name, :breed, :age, :description, photos: [])
  end

end
