require 'rails_helper'

RSpec.describe CustomersController, type: :controller do

    valid_attributes_customer = 
        {
            name: 'testuser',
            username: 'test123',
            password: 'testpassword123',
            food_constraint: 'vegetarian',
            tags: 'indian,jain',
            days: 'Monday',
            chefs: 'Testchef',
            needs: 'true,false',
            description: 'One of the authors of this SaaS app',
            # Add other attributes as needed
        }

    valid_attributes_chef =     {
            name: 'Testchef',
            username: 'test1234',
            password: 'testspassword123',
            food_constraint: 'vegetarian',
            tags: 'indian,gluten-free',
            schedule: 'Paneer Butter Masala,Egg fry',
            days: 'Monday,Tuesday',
            max_customers: '3,4',
            num_customers: '3,3',
            description: 'One of the authors of this SaaS app',
            address: '125 st, New York',
            address_coordinates: '30,40', 
            subscription:'None'
          }
          valid_attributes_chef2 =     {
            name: 'Newchef',
            username: 'testdf1234',
            password: 'testsdsfpassword123',
            food_constraint: 'vegetarian',
            tags: 'indian,gluten-free',
            schedule: 'Paneer Butter Masala,Egg fry',
            days: 'Wednesday,Thursday',
            max_customers: '3,4',
            num_customers: '3,5',
            description: 'One of the authors of this SaaS app',
            address: '125 st, Harlem',
            address_coordinates: '30,40',
            subscription:'Daily'
          }

  customer =  Customer.create!(valid_attributes_customer)
  chef = Chef.create!(valid_attributes_chef)
  chef2 = Chef.create!(valid_attributes_chef2)
    
  describe 'GET #show' do
    context 'when days and chefs are present' do
      it 'assigns the requested customer as @customer' do
        get :show, :id => customer.id
        expect(assigns(:customer)).to eq(customer)
      end

      it 'assigns @days and @chefs' do
        get :show, :id => customer.id
        expect(assigns(:days)).to eq(['Monday'])
        expect(assigns(:chefs)).to eq(['Testchef'])
      end

      it 'assigns @meals' do
        expect(Customer).to receive(:find_dishes).with(['Monday'], ['Testchef']).and_return(['Dish1', 'Dish2'])
        get :show, :id => customer.id
        expect(assigns(:meals)).to eq(['Dish1', 'Dish2'])
      end
    end
  end

  describe 'GET #edit' do

    it 'assigns @chefs_table' do
      # You may need to stub or mock the behavior of Chef.get_chefs_meals method
      expect(Chef).to receive(:get_chefs_meals).and_return(['Chef1', 'Chef2'])
      get :edit, :id => customer.to_param
      expect(assigns(:chefs_table)).to eq(['Chef1', 'Chef2'])
    end
  end

  describe 'PATCH #update' do

    it 'assigns the requested customer as @customer' do
      patch :update, :id => customer.id, :new_entry => {chef: 'Newchef',day: 'Wednesday'}
      expect(assigns(:customer)).to eq(customer)
    end

    it 'updates the customer with the new chef and day' do
      patch :update, :id => customer.id, :new_entry => {chef: 'Newchef',day: 'Wednesday'}
      customer.reload
      expect(customer.chefs).to eq('Testchef,Newchef')
      expect(customer.days).to eq('Monday,Wednesday')
    end

    it 'sets a flash notice' do
      patch :update, :id => customer.id, :new_entry => {chef: 'Newchef',day: 'Wednesday'}
      expect(flash[:notice]).to eq('Your choice was successfully updated!')
    end

    it 'redirects to customer path' do
      patch :update, :id => customer.id, :new_entry => {chef: 'Newchef',day: 'Wednesday'}
      expect(response).to redirect_to(customer_path(customer))
    end

    it 'sets a flash notice and redirects if chef not found' do
      patch :update, :id=> customer.id, :new_entry=>{ chef: 'NonExistentChef', day: 'Wednesday' }
      expect(flash[:notice]).to eq('This entry does not exist!')
      expect(response).to redirect_to(customer_path(customer))
    end
  end

  describe 'GET #choose_entry' do

    it 'assigns the requested customer as @customer' do
      get :choose_entry, :id => customer.id
      expect(assigns(:customer)).to eq(customer)
    end

    it 'assigns @days and @chefs' do
      get :choose_entry, :id => customer.id
      expect(assigns(:days)).to eq(['Monday'])
      expect(assigns(:chefs)).to eq(['Testchef'])
    end

    it 'assigns @meals' do
      # You may need to stub or mock the behavior of Customer.find_dishes method
      expect(Customer).to receive(:find_dishes).with(['Monday'], ['Testchef']).and_return(['Dish1', 'Dish2'])
      get :choose_entry, :id => customer.id
      expect(assigns(:meals)).to eq(['Dish1', 'Dish2'])
    end
  end

  describe 'DELETE #destroy_entry' do

    it 'assigns the requested customer as @customer' do
      delete :destroy_entry, :id => customer.id, :new_entry => {day: 'Monday'}
      expect(assigns(:customer)).to eq(customer)
    end

    it 'removes the specified day and chef from the customer' do
      delete :destroy_entry, :id => customer.id, :new_entry => {day: 'Monday'}
      customer.reload
      expect(customer.chefs).to eq('')
      expect(customer.days).to eq('')
    end

    it 'sets a flash notice' do
      delete :destroy_entry, :id => customer.id, :new_entry => {day: 'Monday'}
      expect(flash[:notice]).to eq('Your entry was successfully deleted!')
    end

    it 'redirects to customer path' do
      delete :destroy_entry, :id => customer.id, :new_entry => {day: 'Monday'}
      expect(response).to redirect_to(customer_path(customer))
    end

    it 'sets a flash notice and redirects if day not found' do
      delete :destroy_entry, :id => customer.id, :new_entry => {day: 'NonExistentDay'}
      expect(flash[:notice]).to eq('No such entry exists')
      expect(response).to redirect_to(customer_path(customer))
    end
  end
end
