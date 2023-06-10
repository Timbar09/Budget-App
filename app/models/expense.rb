class Expense < ApplicationRecord
  belongs_to :author, class_name: 'User'
  has_many :category_expense, dependent: :destroy
  has_many :categories, through: :category_expense

  validates :name, presence: true
  validates :name, length: { minimum: 2, maximum: 20 }
  validates :amount, presence: true
  validates :amount, numericality: { greater_than: 0 }
end
