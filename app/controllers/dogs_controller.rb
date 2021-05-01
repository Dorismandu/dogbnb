class DogsController < ApplicationController
  def index
    @dogs = Dog.all
  end

  def show
    @dog = Dog.find(params[:id])
  end

  def dog_params
    params.require(:dog).permit(:title, :body, :photos [])
  end
end
