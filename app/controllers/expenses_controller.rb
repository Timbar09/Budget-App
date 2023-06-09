class ExpensesController < ApplicationController
  before_action :set_category

  def index
    @expenses = @category.expenses.order(created_at: :desc)

    @total = @expenses.sum(:amount)
  end

  def new
    @expense = Expense.new
  end

  def create
    @expense = @category.expenses.new(expense_params)

    if @expense.save
      flash[:notice] = 'Expense was successfully created.'
      redirect_to category_expenses_path(@category)
    else
      flash[:alert] = 'Expense could not be created.'
      render :new
    end
  end

  private

  def set_category
    @category = Category.find(params[:category_id])
  end

  def expense_params
    params.require(:expense).permit(:name, :amount).merge(author: current_user)
  end
end