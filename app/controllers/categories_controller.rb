class CategoriesController < ApplicationController
  def index
    @categories = Category.includes(:expenses).where(author: current_user).order(:created_at :desc)

    @categories.each do |category|
      category.total = category.expenses.sum(:amount)
    end
  end

  def new
    @category = Category.new
  end

  def create
    @category = Category.new(category_params)

    if @category.save
      flash[:notice] = 'Category was successfully created.'
      redirect_to categories_path
    else
      flash[:alert] = 'Category was not created.'
      render :new
    end
  end

  private

  def category_params
    params.require(:category).permit(:name, :icon).merge(author: current_user)
  end
end
