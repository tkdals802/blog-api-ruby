class Api::CategoriesController < ApplicationController
  # GET /categories
  # main pageでcategory listを造る
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
