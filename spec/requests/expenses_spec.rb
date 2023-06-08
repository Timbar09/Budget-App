require 'rails_helper'

RSpec.describe "Expenses", type: :request do
  describe "GET /expenses" do
    before :each do
      @cr7 = User.create(name: 'Cristiano', email: 'cr7@goat,baller', password: 'password')
      sign_in @cr7

      @sports = Category.create(name: 'Football', author: @cr7)

      # Create a sample image file for the categories
      image_path = Rails.root.join('spec', 'fixtures', 'files', 'category_icon.jpg')
      file = fixture_file_upload(image_path, 'image/jpg')
      @sports.icon.attach(io: File.open(file.path), filename: 'category_icon.jpg')

      @sports.expenses.create(name: 'Nike Mercurial', amount: 200, author: @cr7)
      @sports.expenses.create(name: 'Long Sleeve Jersey', amount: 100, author: @cr7)
    end

    it "returns http success" do
      get category_expenses_path(@sports)

      expect(response).to have_http_status(:success)
    end

    it "lists all expenses belonging to a category" do
      get category_expenses_path(@sports)

      expect(response.body).to include(@sports.expenses.first.name)
      expect(response.body).to include(@sports.expenses.last.name)
    end

    it "lists all expenses belonging to a user" do
      get category_expenses_path(@sports)

      expect(response.body).to include(@sports.expenses.first.name)
      expect(response.body).to include(@sports.expenses.last.name)
    end
  end
end