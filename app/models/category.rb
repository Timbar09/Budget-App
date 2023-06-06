class Category < ApplicationRecord
  belongs_to :author, class_name: 'User'
  has_and_belongs_to_many :categories_transactions, class_name: 'Transaction'

  has_one_attached :icon
end
