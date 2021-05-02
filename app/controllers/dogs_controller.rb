class DogsController < ApplicationController
  before_action :set_dog, only: [:show]
  def index
    @dogs = policy_scope(Dog).order(created_at: :desc)
  end

  def show
    #@dog = Dog.find(params[:id])
    @booking = Booking.new
    authorize @booking
    
  end

  private

  def set_dog
    @dog = Dog.find(params[:id])
    authorize @dog
  end

end
