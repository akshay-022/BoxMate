require 'rails_helper'

RSpec.describe CustomerinfosController, type: :controller do
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

  describe 'GET #show' do
    it 'assigns the requested customerinfo as @customerinfo' do
      customerinfo = Customerinfo.create!(valid_customer_attributes)
      session[:customer_username] = customerinfo.username
      get :show, :id => customerinfo.to_param
      expect(assigns(:customerinfo)).to eq(customerinfo)
    end
  end

  describe 'GET #edit' do
    it 'assigns the requested customerinfo as @customerinfo' do
      customerinfo = Customerinfo.create!(valid_customer_attributes)
      session[:customer_username] = customerinfo.username
      get :edit, :id => customerinfo.to_param
      expect(assigns(:customerinfo)).to eq(customerinfo)
    end
    context 'when cuisines and sort are present in session' do
        it 'redirects to edit_customerinfo_path with session values' do
            customerinfo = Customerinfo.create!(valid_customer_attributes)
            session[:customer_username] = customerinfo.username
          session[:cuisines] = { 'cuisine1' => '1', 'cuisine2' => '1' }
          session[:sort] = 'some_sort'
      
          get :edit, id: customerinfo.id
      
          expect(response).to redirect_to(edit_customerinfo_path(sort: 'some_sort', cuisines: session[:cuisines]))
        end
      end
  end

  describe 'PUT #update' do
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

    it 'updates the customerinfo and redirects to the show page' do
      test_chef = Chefinfo.create!(valid_chef_attributes)
      customerinfo = Customerinfo.create!(valid_customer_attributes)
      session[:customer_username] = customerinfo.username

      expect(Chefinfo.find_by(name: test_chef.name)).not_to be_nil
      chefmeal = Chefmeal.create!(
        username: test_chef.username,
        meal: 'Meal1',
        days: 'Monday',
        mealtime: 'Lunch',
        max_customers: 3,
        num_customers: 1,
        chefinfo_id: test_chef.id,
        cuisine: 'Indian'
      )

      put :update, id: customerinfo.id, chefmealid: chefmeal.id
      customerinfo.reload

      expect(flash[:notice]).to eq('Your choice was successfully updated!')
      expect(response).to redirect_to(customerinfo_path(customerinfo))

      Chefinfo.find_by(name: test_chef.name).destroy
      chefmeal.destroy
    end
    it 'increments num_meals for existing customermeal' do
        test_chef = Chefinfo.create!(valid_chef_attributes)
        customerinfo = Customerinfo.create!(valid_customer_attributes)
        session[:customer_username] = customerinfo.username

        expect(Chefinfo.find_by(name: test_chef.name)).not_to be_nil
        chefmeal = Chefmeal.create!(
          username: test_chef.username,
          meal: 'Meal1',
          days: 'Monday',
          mealtime: 'Lunch',
          max_customers: 3,
          num_customers: 1,
          chefinfo_id: test_chef.id,
          cuisine: 'Indian'
        )

        existing_customermeal = Customermeal.create!(
          username: customerinfo.username,
          chefmeal_id: chefmeal.id,
          customerinfo_id: customerinfo.id,
          num_meals: 1
        )

        put :update, id: customerinfo.id, chefmealid: chefmeal.id
        existing_customermeal.reload

        expect(existing_customermeal.num_meals).to eq(2)

        Chefinfo.find_by(name: test_chef.name).destroy
        chefmeal.destroy
        existing_customermeal.destroy
    end
  end

  describe 'DELETE #destroy_entry' do
    it 'destroys the requested customermeal and redirects to the customerinfo page' do
        customerinfo = Customerinfo.create!(valid_customer_attributes)
        test_chef = Chefinfo.create!(
          name: 'Test Chef',
          username: 'test_chef',
          password: 'password123',
          food_constraint: 'vegetarian',
          tags: 'tag1, tag2',
          description: 'Chef description',
          address: 'Test Chef Address',
          address_coordinates: '12.345,67.890'
        )
        chefmeal = Chefmeal.create!(
          username: test_chef.username,
          meal: 'Meal1',
          days: Date.new(2023, 11, 15),
          mealtime: 'Lunch',
          max_customers: 3,
          num_customers: 1,
          chefinfo_id: test_chef.id,
          cuisine: 'test_cuisine'
        )
        customermeal = Customermeal.create!(
          username: customerinfo.username,
          chefmeal_id: chefmeal.id,
          customerinfo_id: customerinfo.id,
          num_meals: 1
        )
      
        session[:customer_username] = customerinfo.username
        delete :destroy_entry, id: customerinfo.to_param, :customermealid => customermeal.id
      
        expect(flash[:notice]).to eq('Your entry was successfully deleted!')
        expect(response).to redirect_to(customerinfo_path(customerinfo))
    end

    it 'destroys the requested customermeal and redirects to the customerinfo page' do
        customerinfo = Customerinfo.create!(valid_customer_attributes)
        test_chef = Chefinfo.create!(
          name: 'Test Chef',
          username: 'test_chef',
          password: 'password123',
          food_constraint: 'vegetarian',
          tags: 'tag1, tag2',
          description: 'Chef description',
          address: 'Test Chef Address',
          address_coordinates: '12.345,67.890'
        )
        chefmeal = Chefmeal.create!(
          username: test_chef.username,
          meal: 'Meal1',
          days: Date.new(2023, 11, 15),
          mealtime: 'Lunch',
          max_customers: 3,
          num_customers: 1,
          chefinfo_id: test_chef.id,
          cuisine: 'test_cuisine'
        )
        customermeal = Customermeal.create!(
          username: customerinfo.username,
          chefmeal_id: chefmeal.id,
          customerinfo_id: customerinfo.id,
          num_meals: 3
        )
      
        session[:customer_username] = customerinfo.username
        delete :destroy_entry, id: customerinfo.to_param, :customermealid => customermeal.id

        expect(flash[:notice]).to eq('Your entry was successfully deleted!')
        expect(response).to redirect_to(customerinfo_path(customerinfo))
    end
  end

  describe 'before_action #authenticate_customer!' do
    it 'redirects to the root path with a notice when not authenticated' do
      customerinfo = Customerinfo.create!(valid_customer_attributes)
      get :show, :id => customerinfo.to_param
      expect(response).to redirect_to(root_path)
      expect(flash[:notice]).to eq('You are not authorized to access this page.')
    end

    it 'does not redirect when authenticated' do
      customerinfo = Customerinfo.create!(valid_customer_attributes)
      session[:customer_username] = customerinfo.username
      get :show, :id => customerinfo.to_param
      expect(response).not_to redirect_to(root_path)
    end
  end

  describe 'GET #choose_entry' do
    it 'assigns the requested customerinfo and meal details as @customerinfo, @days, @mealtimes, @chefs, and @meals' do
        customerinfo = Customerinfo.create!(valid_customer_attributes)
        session[:customer_username] = customerinfo.username

        get :choose_entry, id: customerinfo.to_param

        expect(assigns(:customerinfo)).to eq(customerinfo)
        expect(assigns(:days)).to be_a(Array)
        expect(assigns(:mealtimes)).to be_a(Array)
        expect(assigns(:chefs)).to be_a(Array)
        expect(assigns(:meals)).to be_a(Array)
    end

    it 'assigns the requested customerinfo and meal details as @customerinfo, @days, @mealtimes, @chefs, and @meals' do
      customerinfo = Customerinfo.create!(valid_customer_attributes)
      session[:customer_username] = customerinfo.username

      valid_chef_attributes = 
      {
        name: 'Test Chef',
        username: 'test_chef',
        password: 'password123',
        food_constraint: 'vegetarian',
        tags: 'tag1, tag2',
        description: 'Test Chef description',
        address: 'Test Chef Address',
        address_coordinates: '12.345,67.890'
      }
      test_chef = Chefinfo.create!(valid_chef_attributes)

      chefmeal = Chefmeal.create!(
        username: test_chef.username,
        meal: 'Meal1',
        days: 'Monday',
        mealtime: 'Lunch',
        max_customers: 3,
        num_customers: 1,
        chefinfo_id: test_chef.id,
        cuisine: 'Indian'
      )

      customermeal = Customermeal.create!(
        username: customerinfo.username,
        chefmeal_id: chefmeal.id,
        customerinfo_id: customerinfo.id
      )

      get :choose_entry, id: customerinfo.to_param

      expect(assigns(:customerinfo)).to eq(customerinfo)
      expect(assigns(:days)).to be_a(Array)
      expect(assigns(:mealtimes)).to be_a(Array)
      expect(assigns(:chefs)).to be_a(Array)
      expect(assigns(:meals)).to be_a(Array)
      expect(assigns(:customermeal_ids)).to be_a(Array)

      Chefinfo.find_by(name: test_chef.name).destroy
      chefmeal.destroy
      customermeal.destroy
    end
  end

  describe 'GET #subscribe' do
    valid_chef_attributes = {
      name: 'Test Chef',
      username: 'test_chef',
      password: 'password123',
      food_constraint: 'vegetarian',
      tags: 'tag1, tag2',
      description: 'Chef description',
      address: 'Test Chef Address',
      address_coordinates: '12.345,67.890'
    }
    it 'subscribes the customer to available chef meals' do
      test_chef = Chefinfo.create!(valid_chef_attributes)
      customer = Customerinfo.create!(valid_customer_attributes)
      chefmeal = Chefmeal.create!(
        username: test_chef.username,
        meal: 'Meal1',
        days: 'Monday',
        mealtime: 'Lunch',
        max_customers: 3,
        num_customers: 1,
        chefinfo_id: test_chef.id,
        cuisine: 'Indian'
      )

      get :subscribe, id: customer.to_param, chefname: test_chef.id, customername: customer.id

      expect(response).to redirect_to(customerinfo_path(customer))
      expect(flash[:notice]).to eq('Subscribed!')

      Chefinfo.find_by(name: test_chef.name).destroy
      chefmeal.destroy
      customer.destroy
    end

    it 'does not subscribe the customer if chef meals are at max capacity' do
      test_chef = Chefinfo.create!(valid_chef_attributes)
      customer = Customerinfo.create!(valid_customer_attributes)
      chefmeal = Chefmeal.create!(
        username: test_chef.username,
        meal: 'Meal1',
        days: 'Monday',
        mealtime: 'Lunch',
        max_customers: 1,
        num_customers: 1,
        chefinfo_id: test_chef.id,
        cuisine: 'Indian'
      )

      get :subscribe, id: customer.to_param, chefname: test_chef.id, customername: customer.id

      expect(response).to redirect_to(customerinfo_path(customer))
      expect(flash[:notice]).to eq('No meals added - chef is at max capacity or you are fully subscribed.')

      Chefinfo.find_by(name: test_chef.name).destroy
      chefmeal.destroy
      customer.destroy
    end
  end
end
