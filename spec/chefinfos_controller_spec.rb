# spec/controllers/chefinfos_controller_spec.rb
require 'rails_helper'

RSpec.describe ChefinfosController, type: :controller do
  let(:valid_attributes) {
    {
      name: 'Test Chef',
      food_constraint: 'vegetarian',
      tags: 'tag1, tag2',
      description: 'Chef description',
      address: 'Test Address',
      address_coordinates: '12.345,67.890',
      username: 'test_chef',
      password: 'password123',
      subscription: 'basic'
    }
  }

  let(:invalid_attributes) {
    {
      name: '',
      food_constraint: 'invalid_constraint',
      tags: 'tag1, tag2',
      description: 'Chef description',
      address: 'Test Address',
      address_coordinates: '12.345,67.890',
      username: 'test_chef',
      password: 'password123',
      subscription: 'basic'
    }
  }

  describe 'GET #show' do
    it 'assigns the requested chefinfo as @chefinfo' do
      chefinfo = Chefinfo.create! valid_attributes
      get :show, :id => chefinfo.to_param
      expect(assigns(:chefinfo)).to eq(chefinfo)
    end
  end

  describe 'GET #edit' do
    it 'assigns the requested chefinfo as @chefinfo' do
      chefinfo = Chefinfo.create! valid_attributes
      session[:chef_username] = chefinfo.username
      get :edit, :id => chefinfo.to_param
      expect(assigns(:chefinfo)).to eq(chefinfo)
    end
  end

  describe 'PUT #update' do
    context 'with valid params' do
      it 'updates the requested chefinfo' do
        chefinfo = Chefinfo.create!(valid_attributes)
        session[:chef_username] = chefinfo.username
        put :update, :id => chefinfo.id, :subscription => 'premium'
        chefinfo.reload
        expect(chefinfo.subscription).to eq('premium')
      end
    end

    context 'with valid params for meal update' do
      it 'updates the requested chefinfo and creates a new Chefmeal' do
        chefinfo = Chefinfo.create!(valid_attributes)
        session[:chef_username] = chefinfo.username
        expect {
          put :update, :id => chefinfo.id, :subscription => chefinfo.subscription, :new_entry => { meal: 'New Meal', max_customers: 5 }, :mealtime => 'Lunch', :day => Date.today
          chefinfo.reload
        }.to change { Chefmeal.count }.by(1)
        expect(flash[:notice]).to eq('Your info was successfully updated!')
      end
    end

    context 'with no changes' do
      it 'displays no changes entered' do
        chefinfo = Chefinfo.create!(valid_attributes)
        session[:chef_username] = chefinfo.username
        put :update, :id => chefinfo.id, :subscription => chefinfo.subscription, :new_entry => {meal: ""}
        expect(flash[:notice]).to eq('No changes entered.')
      end
    end
  end


  describe 'GET #choose_entry' do
    it 'assigns the requested chefinfo and chefmeals as @chefinfo and @chefmeals' do
      chefinfo = Chefinfo.create! valid_attributes
      session[:chef_username] = chefinfo.username
      get :choose_entry, :id => chefinfo.to_param
      expect(assigns(:chefinfo)).to eq(chefinfo)
      expect(assigns(:chefmeals)).to eq(chefinfo.chefmeals)
    end
  end

  describe 'GET #see_meal' do
    it 'assigns the requested chefmeal and related customer information as @chefmeal and @customer_info' do
      chefinfo = Chefinfo.create! valid_attributes
      session[:chef_username] = chefinfo.username
      chefmeal = Chefmeal.create!(meal: 'Test Meal', days: Date.today, mealtime: 'Lunch', max_customers: 5, num_customers: 0, chefinfo_id: chefinfo.id, username: chefinfo.username)
      customer1_attributes = {
        name: 'Customer 1',
        username: 'customer1',
        password: 'password123',
        food_constraint: 'vegetarian',
        tags: 'tag1, tag2',
        description: 'Customer 1 description',
        address: 'Customer 1 Address',
        address_coordinates: '40.7128, -74.0060'
      }

      customer2_attributes = {
        name: 'Customer 2',
        username: 'customer2',
        password: 'password456',
        food_constraint: 'non-vegetarian',
        tags: 'tag3, tag4',
        description: 'Customer 2 description',
        address: 'Customer 2 Address',
        address_coordinates: '34.0522, -118.2437'
      }
      customer1 = Customerinfo.create!(customer1_attributes)
      customer2 = Customerinfo.create!(customer2_attributes)
      
      Customermeal.create!(username: customer1.username, chefmeal_id: chefmeal.id, customerinfo_id: customer1.id)
      Customermeal.create!(username: customer2.username, chefmeal_id: chefmeal.id, customerinfo_id: customer2.id)
      get :see_meal, :id => chefinfo.id, :chefmealid => chefmeal.to_param
      expect(assigns(:chefmeal)).to eq(chefmeal)
      expect(assigns(:customer_info)).to contain_exactly(customer1, customer2)
    end
  end

  describe 'DELETE #destroy_entry' do
    it 'destroys the requested chefmeal and redirects to the chefinfo page' do
      chefinfo = Chefinfo.create! valid_attributes
      session[:chef_username] = chefinfo.username
      chefmeal = Chefmeal.create!(meal: 'Test Meal', days: Date.today, mealtime: 'Lunch', max_customers: 5, num_customers: 0, chefinfo_id: chefinfo.id, username: chefinfo.username)
      delete :destroy_entry, :id => chefinfo.to_param, :day => chefmeal.days, :mealtime => chefmeal.mealtime
      expect(flash[:notice]).to eq('Your entry was successfully deleted!')
      expect(response).to redirect_to(chefinfo_path(chefinfo))
    end

    it 'handles the case where the meal to delete does not exist' do
      chefinfo = Chefinfo.create! valid_attributes
      session[:chef_username] = chefinfo.username
      delete :destroy_entry, :id => chefinfo.to_param, :day => Date.today, :mealtime => 'Lunch'
      expect(flash[:notice]).to eq('No such entry exists')
      expect(response).to redirect_to(chefinfo_path(chefinfo))
    end
  end

  describe 'before_action #authenticate_chef!' do
    it 'redirects to the root path with a notice when not authenticated' do
      chefinfo = Chefinfo.create! valid_attributes
      get :show, :id => chefinfo.to_param
      expect(response).to redirect_to(root_path)
      expect(flash[:notice]).to eq('You are not authorized to access this page.')
    end

    it 'does not redirect when authenticated' do
      chefinfo = Chefinfo.create! valid_attributes
      session[:chef_username] = chefinfo.username
      get :show, :id => chefinfo.to_param
      expect(response).not_to redirect_to(root_path)
    end
  end
end
