class ReviewsController < ApplicationController

  def create
    @review = Review.new(review_params)
    authorize @review
    @booking = Booking.find(params[:booking_id])
    @review.booking = @booking
    if @review.save
      redirect_to dog_path(@dog)
    else
      render 'bookings/show'
    end
  end

  def destroy
    @review = Review.find(params[:id])
    authorize @review
    @review.destroy
    redirect_to dog_path(@dog)
  end

  private

  def review_params
    params.require(:review).permit(:comment, :rating)
  end
end
