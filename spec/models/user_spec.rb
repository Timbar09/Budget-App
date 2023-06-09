require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'creation' do
    before :each do
      @cr7 = User.create(name: 'Cristiano', email: 'cr7@goat.baller', password: 'password')
    end

    it 'can be created' do
      expect(@cr7).to be_valid
    end

    it 'cannot be created without a name' do
      @cr7.name = nil
      expect(@cr7).to_not be_valid
    end

    it 'cannot be created without an email' do
      @cr7.email = nil
      expect(@cr7).to_not be_valid
    end

    it 'cannot be created with a name less than 2 characters' do
      @cr7.name = 'a'
      expect(@cr7).to_not be_valid
    end

    it 'cannot be created with a name more than 20 characters' do
      @cr7.name = 'a' * 21
      expect(@cr7).to_not be_valid
    end
  end
end
