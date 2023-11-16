require 'rails_helper'

RSpec.describe CommonsController, type: :controller do
  describe 'GET #signIn' do
    it 'responds with success' do
      get :signIn
      expect(response).to have_http_status(:success)
    end
  end

  describe 'GET #signup_chef' do
    it 'responds with success' do
      get :signup_chef
      expect(response).to have_http_status(:success)
    end
  end

  describe 'GET #signup_customer' do
    it 'responds with success' do
      get :signup_customer
      expect(response).to have_http_status(:success)
    end
  end

  describe 'POST #signin_intermediate' do
    valid_chef_params = { username: 'valid_chef', password: 'password123' } 

    valid_customer_params = { username: 'valid_customer', password: 'password123' } 

    it 'redirects to chefinfo_path for valid chef credentials' do
      Chefinfo.create!(username: 'valid_chef', password: 'password123', name: 'Chef Name', address: 'Chef Address', address_coordinates: '12.345,67.890')
      post :signin_intermediate, :common => valid_chef_params
      expect(response).to redirect_to(chefinfo_path(Chefinfo.last))
    end

    it 'redirects to customerinfo_path for valid customer credentials' do
      Customerinfo.create!(username: 'valid_customer', password: 'password123', name: 'Customer Name', address: 'Customer Address', address_coordinates: '12.345,67.890')
      post :signin_intermediate, common: valid_customer_params
      expect(response).to redirect_to(customerinfo_path(Customerinfo.last))
    end

    it 'redirects to commons_path for invalid username' do
      post :signin_intermediate, common: { username: 'invalid_user', password: 'password123' }
      expect(response).to redirect_to(commons_path)
    end

    it 'redirects to commons_path for invalid password for chef' do
      Chefinfo.create!(username: 'valid_chef', password: 'password123', name: 'Chef Name', address: 'Chef Address', address_coordinates: '12.345,67.890')
      post :signin_intermediate, common: { username: 'valid_chef', password: 'wrong_password' }
      expect(response).to redirect_to(commons_path)
    end

    it 'redirects to commons_path for invalid password for customer' do
        Customerinfo.create!(username: 'valid_customer', password: 'password123', name: 'Customer Name', address: 'Customer Address', address_coordinates: '12.345,67.890')
        post :signin_intermediate, common: { username: 'valid_customer', password: 'wrong_password' }
        expect(response).to redirect_to(commons_path)
      end
  end

  describe 'POST #signup_chef_intermediate' do
    valid_chef_params =  {
          username: 'new_chef',
          password: 'password123',
          name: 'New Chef Name',
          address: 'New Chef Address',
          address_coordinate_x: '12.345',
          address_coordinate_y: '67.890',
          tags: 'tag1,tag2',
          food_constraint: 'vegetarian',
          description: 'New Chef Description',
          subscription: 'None'
        }

    it 'creates a new Chefinfo and redirects to commons_path' do
      post :signup_chef_intermediate, common: valid_chef_params
      expect(response).to redirect_to(commons_path)
      expect(flash[:notice]).to eq('Your profile was successfully created!!')
    end

    it 'redirects to commons_path for duplicate username' do
      Chefinfo.create!(username: 'existing_chef', password: 'password123', name: 'Existing Chef', address: 'Existing Chef Address', address_coordinates: '12.345,67.890')
      post :signup_chef_intermediate, common: { username: 'existing_chef', password: 'password123' }
      expect(response).to redirect_to(commons_path)
      expect(flash[:notice]).to eq('Username Taken :((')
    end
  end

  describe 'POST #signup_customer_intermediate' do
    valid_customer_params =  {
          username: 'new_customer',
          password: 'password123',
          name: 'New Customer Name',
          address: 'New Customer Address',
          address_coordinate_x: '12.345',
          address_coordinate_y: '67.890',
          tags: 'tag1,tag2',
          food_constraint: 'vegetarian',
          description: 'New Customer Description'
        }

    it 'creates a new Customerinfo and redirects to commons_path' do
      post :signup_customer_intermediate, common: valid_customer_params
      expect(response).to redirect_to(commons_path)
      expect(flash[:notice]).to eq('Your profile was successfully created!!')
    end

    it 'redirects to commons_path for duplicate username' do
      Customerinfo.create!(username: 'existing_customer', password: 'password123', name: 'Existing Customer', address: 'Existing Customer Address', address_coordinates: '12.345,67.890')
      post :signup_customer_intermediate, common: { username: 'existing_customer', password: 'password123' }
      expect(response).to redirect_to(commons_path)
      expect(flash[:notice]).to eq('Username Taken :((')
    end
  end

  describe 'GET #destroy' do
    it 'logs out successfully and redirects to root_path' do
      session[:chef_username] = 'logged_in_chef'
      session[:customer_username] = 'logged_in_customer'
      get :destroy
      expect(session[:chef_username]).to be_nil
      expect(session[:customer_username]).to be_nil
      expect(response).to redirect_to(root_path)
      expect(flash[:notice]).to eq('Logged out successfully')
    end
  end
end
