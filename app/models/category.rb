class Category < ApplicationRecord
  belongs_to :author, class_name: 'User'
  has_many :category_expense, dependent: :destroy
  has_many :expenses, through: :category_expense

  attr_accessor :total
  
  has_one_attached :icon

  validates :name, presence: true
  validates :name, length: { minimum: 2, maximum: 20 }
end
