class Category < ApplicationRecord
  belongs_to :author, class_name: 'User'
  has_many :transactions, dependent: :destroy
end
