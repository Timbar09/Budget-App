require 'rails_helper'

RSpec.describe "Categories", type: :request do
  describe "GET /index" do
    before :each do
      @cr7 = User.create(name: 'Cristiano', email: 'cr7@goat.baller', password: 'password')
      sign_in @cr7

      @sports = Category.create(name: 'Football', author: @cr7)
      @modeling = Category.create(name: 'Modeling', author: @cr7)

      # Create a sample image file for the categories
      image_path = Rails.root.join('spec', 'fixtures', 'files', 'category_icon.jpg')
      file = fixture_file_upload(image_path, 'image/jpg')
      @sports.icon.attach(io: File.open(file.path), filename: 'category_icon.jpg')
      @modeling.icon.attach(io: File.open(file.path), filename: 'category_icon.jpg')

    end

    it "returns http success" do
      get '/categories'
      expect(response).to have_http_status(:success)
    end

    it "lists all categories" do
      get '/categories'
      expect(response.body).to include(@sports.name)
      expect(response.body).to include(@modeling.name)
    end

    it "lists all categories belonging to a user" do
      get '/categories'
      expect(response.body).to include(@sports.name)
      expect(response.body).to include(@modeling.name)
    end
  end
end
