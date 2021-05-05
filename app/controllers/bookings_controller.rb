class BookingsController < ApplicationController
  before_action :set_booking, only: [:show]

  def index
    all_bookings = policy_scope(Booking).order(created_at: :desc)
    @bookings = all_bookings.select { |booking| booking.user == current_user}
  end

  def new
    @dog = Dog.find(params[:dog_id])
    @booking = Booking.new
    authorize @booking
  end

  def create
    @booking = Booking.new(booking_params)
    authorize @booking
    @dog = Dog.find(params[:dog_id])

    @booking.dog = @dog
    @booking.user = current_user
    @booking.status = 0
    @booking.pickup_time = DateTime.current.beginning_of_day
    @booking.giveback_time = DateTime.current.beginning_of_day + 1
    @booking.pickup_location = @dog.address
    @booking.giveback_location = @dog.address
    if @booking.save!
      redirect_to bookings_path
    else
      render :new
    end
  end

  def show
    # for the 'simple_form_for' in bookings show page
    @review = Review.new
  end

  def destroy
  end

  private

  def set_booking
    @booking = Booking.find(params[:id])
    authorize @booking
  end

  def booking_params
    params.require(:booking).permit(:activity, :pickup_time, :giveback_time)
  end

end
