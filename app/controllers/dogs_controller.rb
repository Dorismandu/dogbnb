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
    @reviews = []
    @dog.bookings.each { |booking| @reviews << booking.review }
  end

  private

  def set_dog
    @dog = Dog.find(params[:id])
    authorize @dog
  end

end
