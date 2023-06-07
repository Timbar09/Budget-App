class CategoriesController < ApplicationController
  def index
    @categories = Category.includes(:categories_transactions).where(author: current_user)
    
    @categories.each do |category|
      category.total = category.categories_transactions.sum(&:amount)
    end
  end

  def new
    @category = Category.new
  end

  def create
    @category = Category.new(category_params.merge(author: current_user))

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
    params.require(:category).permit(:name, :icon)
  end
end
