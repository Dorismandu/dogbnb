class PetsController < ApplicationController

  def index
    @pets = Pets.all
  end

  def show
    @pet = Pet.new
  end

end
