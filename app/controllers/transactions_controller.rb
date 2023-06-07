class TransactionsController < ApplicationController
  before_action :set_category

  def index
    @transactions = @category.categories_transactions.includes(:category).where(author: current_user)
    @total = @category.total
  end

  def new
    @transaction = Transaction.new
  end

  def create
    @transaction = Transaction.new(transaction_params.merge(category: @category))

    if @transaction.save
      flash[:notice] = 'Transaction was successfully created.'
      redirect_to category_transactions_path(@category)
    else
      flash[:alert] = 'Transaction was not created.'
      render :new
    end
  end

  private

  def set_category
    @category = Category.find(params[:category_id])
  end

  def transaction_params
    params.require(:transaction).permit(:name, :amount)
  end
end