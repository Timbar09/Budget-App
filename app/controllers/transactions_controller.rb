class TransactionsController < ApplicationController
  def index
    @category = Category.find(params[:category_id])

    @transactions = @category.transactions.order(created_at: :desc)
    @total = @transactions.sum(:amount)
  end

  def new
    @category = Category.find(params[:category_id])
    @transaction = Transaction.new
  end

  def create
    @category = Category.find(params[:category_id])
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

  def transaction_params
    params.require(:transaction).permit(:name, :amount)
  end
end