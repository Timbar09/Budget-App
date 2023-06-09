class ExpensesController < ApplicationController
  def index
    @category = Category.find(params[:category_id])

    @expenses = @category.expenses.includes(:categories).order(:created_at => :desc)

    @total = @expenses.sum(:amount)
  end

  def new
    @category = Category.find(params[:category_id])
    @expense = Expense.new
  end

  def create
    category_id = params[:expense][:category_id]
    @category = Category.find(category_id)
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

  def expense_params
    params.require(:expense).permit(:name, :amount).merge(author: current_user)
  end
end