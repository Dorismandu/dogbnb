class BookingsController < ApplicationController
  before_action :set_booking, only: [:show]

  def index
    @bookings = Booking.all
  end

  def new
    @dog = Dog.find(params[:dog_id])
    @booking = Booking.new
  end

  def create
    @booking = Booking.new(booking_params)
    @dog = Dog.find(params[:dog_id])

    @booking.dog = @dog
    @booking.user = current_user
    @booking.status = 0
    @booking.pickup_time = DateTime.current.beginning_of_day
    @booking.giveback_time = DateTime.current.beginning_of_day + 1
    @booking.pickup_location = @dog.address
    @booking.giveback_location = @dog.address
    @booking.save
    redirect_to bookings_path
  end

  def show

  end

  def destroy
  end


  private

  def set_booking
    @booking = Booking.find(params[:id])
  end

  def booking_params
    params.require(:booking).permit(:activity)
  end

end
