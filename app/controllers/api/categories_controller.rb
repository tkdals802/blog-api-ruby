class Api::CategoriesController < ApplicationController
  def index
    @categories = Category.all
    render json: @categories
  end

  def show
  end

  def create
  end

  def destroy
  end
end
