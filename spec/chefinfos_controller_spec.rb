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
      password: 'password123'
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
      password: 'password123'
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
    context 'with missing fields' do
      it 'sets a flash notice and redirects to the chefinfo show page' do
        chefinfo = Chefinfo.create!(valid_attributes)
        session[:chef_username] = chefinfo.username
        put :update, id: chefinfo.id, new_entry: { meal: '', max_customers: '' }
        expect(response).to redirect_to(chefinfo_path(chefinfo))
        expect(flash[:notice]).to eq('Some fields missing.')
      end
    end

    context 'with valid subscription update' do
      it 'updates the subscription and redirects to the chefinfo show page' do
        chefinfo = Chefinfo.create!(valid_attributes)
        session[:chef_username] = chefinfo.username
        put :update, id: chefinfo.id, subscription: 'None', new_entry: { meal: 'Maggi', max_customers: 10}, mealtime: 'Lunch', day: Date.today
        expect(response).to redirect_to(chefinfo_path(chefinfo))
        expect(flash[:notice]).to eq('Your info was successfully updated!')
      end
    end

    context 'with valid meal update and subscription set to Daily' do
      it 'creates multiple Chefmeals for each day and redirects to the chefinfo show page' do
        chefinfo = Chefinfo.create!(valid_attributes)
        session[:chef_username] = chefinfo.username
        put :update, id: chefinfo.id, subscription: 'Daily', new_entry: { meal: 'New Meal', max_customers: 5 }, mealtime: 'Lunch', day: Date.today
        expect(response).to redirect_to(chefinfo_path(chefinfo))
        expect(flash[:notice]).to eq('Your regular meals have been added!')
        chefinfo.reload
        expect(Chefmeal.count).to eq(5)
        expect(chefinfo.chefmeals.pluck(:meal)).to all(eq('New Meal'))
        expect(chefinfo.chefmeals.pluck(:max_customers)).to all(eq(5))
      end
    end

    context 'with valid parameters' do
      it 'updates chef meals and subscriptions' do
        chefinfo = Chefinfo.create!(valid_attributes)
        session[:chef_username] = chefinfo.username
        customer = Customerinfo.create!(name: 'Customer', username: 'customer', password: 'password123')
        subscription = Subscription.create!(chefinfo_id: chefinfo.id, customerinfo_id: customer.id)
  
        put :update, id: chefinfo.id, new_entry: { meal: 'New Meal', max_customers: 3 }, day: '2023-12-18', mealtime: 'Lunch', subscription: 'Daily'
  
        expect(response).to redirect_to(chefinfo_path(chefinfo.reload))
        expect(flash[:notice]).to eq('Your regular meals have been added!')
        
        expect(Chefmeal.count).to eq(5) 
        new_meal = Chefmeal.last
        expect(new_meal.meal).to eq('New Meal')
        expect(new_meal.num_customers).to eq(1) 
  
        expect(Customermeal.count).to eq(5)
        customer_meal = Customermeal.last
        expect(customer_meal.chefmeal_id).to eq(new_meal.id)
        expect(customer_meal.customerinfo_id).to eq(customer.id)
        expect(customer_meal.num_meals).to eq(1)
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
      
      customermeal1 = Customermeal.create!(username: customer1.username, chefmeal_id: chefmeal.id, customerinfo_id: customer1.id, num_meals: 1)
      customermeal2 = Customermeal.create!(username: customer2.username, chefmeal_id: chefmeal.id, customerinfo_id: customer2.id, num_meals: 1)
      get :see_meal, :id => chefinfo.id, :chefmealid => chefmeal.to_param
      expect(assigns(:chefmeal)).to eq(chefmeal)
      customer_info_ids = assigns(:customer_info).map(&:customerinfo_id)
      expected_customer_info_ids = [customer1.id, customer2.id]
      expect(customer_info_ids).to contain_exactly(*expected_customer_info_ids)
    end
  end

  describe 'POST #create_chef_review' do
    let(:chefinfo) { Chefinfo.create!(valid_attributes) }
    customer_attributes = {
        name: 'Customer 1',
        username: 'customer1',
        password: 'password123',
        food_constraint: 'vegetarian',
        tags: 'tag1, tag2',
        description: 'Customer 1 description',
        address: 'Customer 1 Address',
        address_coordinates: '40.7128, -74.0060'
      }
    customerinfo = Customerinfo.create!(customer_attributes)

    it 'creates a new ChefReview and redirects to the chef profile page' do
      post :create_chef_review, id: chefinfo.id, customerinfo_id: customerinfo.id, chef_review: { content: 'Great chef!', rating: 5, chefinfo_id: chefinfo.id, customerinfo_id: customerinfo.id  }

      expect(response).to redirect_to(profile_path(id: chefinfo.id))
      expect(flash[:notice]).to eq('Review successfully submitted.')

      created_review = ChefReview.last
      expect(created_review).to be_present
      expect(created_review.content).to eq('Great chef!')
      expect(created_review.rating).to eq(5)
      expect(created_review.chefinfo).to eq(chefinfo)
      expect(created_review.customerinfo_id).to eq(customerinfo.id)
    end

    it 'redirects to the chef profile page with an error message on failure' do
      chef_review = instance_double(ChefReview)
      allow(ChefReview).to receive(:new).and_return(chef_review)
      allow(chef_review).to receive(:save).and_return(false)
      post :create_chef_review, id: chefinfo.id, customerinfo_id: customerinfo.id, chef_review: { content: '', rating: 6 }

      expect(response).to redirect_to(profile_path(id: chefinfo.id))
      expect(flash[:notice]).to eq('Error: Unable to submit the review.')
    end
  end

  describe 'DELETE #destroy_entry' do
    it 'destroys the requested chefmeal and redirects to the chefinfo page' do
      chefinfo = Chefinfo.create! valid_attributes
      session[:chef_username] = chefinfo.username
      chefmeal = Chefmeal.create!(meal: 'Test Meal', days: Date.today, mealtime: 'Lunch', max_customers: 5, num_customers: 0, chefinfo_id: chefinfo.id, username: chefinfo.username)
      delete :destroy_entry, :id => chefinfo.to_param, :chefmealid => chefmeal.id
      expect(flash[:notice]).to eq('Your entry was successfully deleted!')
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

  describe '.get_distance' do
    let(:chef_coordinates) { '12.345,67.890' }
    let(:customer_coordinates) { '12.350,67.895' }

    it 'calculates distance correctly' do
      chef = Chefinfo.create!(name: 'Test Chef', address_coordinates: chef_coordinates)
      customer = Customerinfo.create!(username: 'test_customer', address_coordinates: customer_coordinates)
      distance = Chefmeal.get_distance(chef_coordinates, customer.username)
      
      expect(distance).to be_within(0.01).of(0.006)
    end
  end
end
