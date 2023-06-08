class Category < ApplicationRecord
  belongs_to :author, class_name: 'User'
  has_many :category_expense, dependent: :destroy
  has_many :expenses, through: :category_expense

  attr_accessor :total
  
  has_one_attached :icon
end
