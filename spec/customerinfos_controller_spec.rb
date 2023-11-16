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
    context 'with valid params' do
        it 'updates the customerinfo and redirects to the show page' do
            # Create a test chef
            test_chef = Chefinfo.create!(
            name: 'Test Chef',
            username: 'test_chef',
            password: 'password123',
            food_constraint: 'vegetarian',
            tags: 'indian',
            description: 'Test Chef description',
            address: 'Test Chef Address',
            address_coordinates: '12.345,67.890',
            subscription: 'None'
            )

            # Create a customer
            customerinfo = Customerinfo.create!(valid_customer_attributes)
            session[:customer_username] = customerinfo.username

            # Ensure the chef exists and cooks on the specified day and cuisine
            chefmeal = Chefmeal.create!(
            username: test_chef.username,
            meal: 'Meal1',
            days: Date.new(2023, 11, 15),
            mealtime: 'Lunch',
            max_customers: 3,
            num_customers: 1,
            chefinfo_id: test_chef.id,
            cuisine: 'indian'  # Corrected cuisine to match the test
            )

            # Perform the update action
            put :update, id: customerinfo.id, new_entry: { chef: test_chef.name, cuisine: 'indian' }, day: '2023-11-15'

            # Reload the customerinfo
            customerinfo.reload

            # Check for a successful update
            expect(flash[:notice]).to eq('Your choice was successfully updated!')

            # Ensure the correct redirection
            expect(response).to redirect_to(customerinfo_path(customerinfo))

            # Clean up: Delete the created records
            Chefinfo.find_by(name: test_chef.name).destroy
            chefmeal.destroy
        end
    end

    context 'with invalid params' do
        it 'chef does not exist' do
            # Create a customer
            customerinfo = Customerinfo.create!(valid_customer_attributes)
            session[:customer_username] = customerinfo.username

            # Perform the update action with a non-existing chef
            put :update, id: customerinfo.id, new_entry: { chef: 'Nonexistent Chef', cuisine: 'Italian' }, day: 'Sunday'

            # Check for the correct flash notice
            expect(flash[:notice]).to eq('This chef does not exist!')

            # Ensure the correct redirection
            expect(response).to redirect_to(edit_customerinfo_path(customerinfo))
        end

        it 'chef does not cook on this day' do
            # Create a test chef
            test_chef = Chefinfo.create!(
            name: 'Test Chef',
            username: 'test_chef',
            password: 'password123',
            food_constraint: 'vegetarian',
            tags: 'indian',
            description: 'Test Chef description',
            address: 'Test Chef Address',
            address_coordinates: '12.345,67.890',
            subscription: 'None'
            )

            # Create a customer
            customerinfo = Customerinfo.create!(valid_customer_attributes)
            session[:customer_username] = customerinfo.username

            # Perform the update action with a chef that does not cook on the specified day
            put :update, id: customerinfo.id, new_entry: { chef: test_chef.name, cuisine: 'Italian' }, day: 'Sunday'

            # Check for the correct flash notice
            expect(flash[:notice]).to eq('This chef does not cook on this day!')

            # Ensure the correct redirection
            expect(response).to redirect_to(edit_customerinfo_path(customerinfo))

            # Clean up: Delete the created records
            Chefinfo.find_by(name: test_chef.name).destroy
        end

        it 'chef does not cook this cuisine this day' do
            # Create a test chef
            test_chef = Chefinfo.create!(
            name: 'Test Chef',
            username: 'test_chef',
            password: 'password123',
            food_constraint: 'vegetarian',
            tags: 'indian',
            description: 'Test Chef description',
            address: 'Test Chef Address',
            address_coordinates: '12.345,67.890',
            subscription: 'None'
            )

            # Create a customer
            customerinfo = Customerinfo.create!(valid_customer_attributes)
            session[:customer_username] = customerinfo.username

            chefmeal = Chefmeal.create!(
            username: test_chef.username,
            meal: 'Meal1',
            days: Date.new(2023, 11, 15),
            mealtime: 'Lunch',
            max_customers: 3,
            num_customers: 1,
            chefinfo_id: test_chef.id,
            cuisine: 'indian'  # Corrected cuisine to match the test
            )

            # Perform the update action with a chef that does not cook the specified cuisine on the specified day
            put :update, id: customerinfo.id, new_entry: { chef: test_chef.name, cuisine: 'Italian' }, day: '2023-11-15'

            # Check for the correct flash notice
            expect(flash[:notice]).to eq('This chef does not cook this cuisine this day!')

            # Ensure the correct redirection
            expect(response).to redirect_to(edit_customerinfo_path(customerinfo))

            # Clean up: Delete the created records
            Chefinfo.find_by(name: test_chef.name).destroy
        end
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
          address_coordinates: '12.345,67.890',
          subscription: 'None'
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
          customerinfo_id: customerinfo.id
        )
      
        # Ensure the entry exists before attempting to delete it
        expect(Customerinfo.get_customer_meal_details(customerinfo)).not_to be_empty
      
        session[:customer_username] = customerinfo.username
        delete :destroy_entry, id: customerinfo.to_param, day: '2023-11-15', mealtime: 'Lunch'
      
        # Expect the flash message to indicate successful deletion
        expect(flash[:notice]).to eq('Your entry was successfully deleted!')
        expect(response).to redirect_to(customerinfo_path(customerinfo))
    end

    it 'handles the case where the entry to delete does not exist' do
      customerinfo = Customerinfo.create!(valid_customer_attributes)
      session[:customer_username] = customerinfo.username
      delete :destroy_entry, :id => customerinfo.to_param, :day => 'Sunday', :mealtime => 'Dinner'
      expect(flash[:notice]).to eq('No such entry exists')
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
  end
end
