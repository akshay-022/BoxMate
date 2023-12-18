require 'rails_helper'

RSpec.describe ProfilesController, type: :controller do
  let(:valid_customer_attributes) {
    {
      name: 'Test Customer',
      username: 'test_customer',
      password: 'password123',
      food_constraint: 'vegetarian',
      tags: 'tag1, tag2',
      description: 'Customer description',
      address: 'Test Address',
      address_coordinates: '12.345,67.890',
    }
  }

  let(:valid_chef_attributes) {
    {
      name: 'Test Chef',
      username: 'test_chef',
      password: 'password123',
      food_constraint: 'vegetarian',
      tags: 'indian',
      description: 'Test Chef description',
      address: 'Test Chef Address',
      address_coordinates: '12.345,67.890'
    }
  }

  describe 'GET #show' do
    it 'assigns the requested profile and related data as @profile, @customer_user, @chef_user, @chefmeals, and @chef_reviews' do
      customerinfo = Customerinfo.create!(valid_customer_attributes)
      session[:customer_username] = customerinfo.username

      chefinfo = Chefinfo.create!(valid_chef_attributes)
      session[:chef_username] = chefinfo.username

      get :show, id: chefinfo.id

      expect(assigns(:profile)).to eq(chefinfo)
      expect(assigns(:customer_user)).to eq(customerinfo)
      expect(assigns(:chef_user)).to eq(chefinfo)
      expect(assigns(:chefmeals)).to eq(chefinfo.chefmeals)
      expect(assigns(:chef_reviews)).to eq(chefinfo.chef_reviews)
    end
  end
end
