class BookingsController < ApplicationController
  before_action :set_booking, only: [:show, :update]

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
    @booking.save
    redirect_to bookings_path
  end

  def show

  end

  def update
    statuses = ["pending", "approved", "denied"]
    message = booking_params[:message]
    status = statuses.index(booking_params[:status])
    @booking.update({message: message, status:status})
    authorize @booking
    redirect_to new_dog_path
  end

  def destroy
  end

  private

  def set_booking
    @booking = Booking.find(params[:id])
    authorize @booking
  end

  def booking_params
    params.require(:booking).permit(:activity, :message, :status)
  end

end
