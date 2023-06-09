class CategoryExpense < ApplicationRecord
  belongs_to :category, class_name: 'Category'
  belongs_to :expense, class_name: 'Expense'
end
