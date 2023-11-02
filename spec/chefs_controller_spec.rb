# spec/controllers/chefs_controller_spec.rb

require 'rails_helper'

RSpec.describe ChefsController, type: :controller do
  let(:valid_attributes) {
    # Define valid attributes for a Chef here
    # For example:
    { name: 'Chef Name', schedule: 'Monday,Tuesday', days: 'Monday,Tuesday', address_coordinates: '12.345,67.890', max_customers: '5,10', num_customers: '2,5' }
  }


  let(:invalid_attributes) {
    # Define invalid attributes for a Chef here
    # For example:
    { name: '', schedule: '', days: '', address_coordinates: '', max_customers: '', num_customers: '' }
  }

  describe 'GET #show' do
    it 'assigns the requested chef as @chef' do
      chef = Chef.create!(valid_attributes)
      get :show, :id => chef.id
      expect(assigns(:chef)).to eq(chef)
    end

    # Add more tests for the 'show' action as needed
  end

  describe 'GET #edit' do
    it 'assigns the requested chef as @chef' do
      chef = Chef.create!(valid_attributes)
      get :edit, :id => chef.to_param
      expect(assigns(:chef)).to eq(chef)
    end
  end

  describe 'PUT #update' do

    it 'updates the requested chef' do
        chef = Chef.create!(valid_attributes)
        put :update, :id => chef.id, :new_entry => {schedule: 'Wednesday', days: 'Thursday', max_customers: '20'}
        chef.reload
        expect(assigns(:chef)).to eq(chef)
    end
  end

  describe "GET #choose_entry" do
    it "returns a successful response" do
      chef = Chef.create!(valid_attributes)
      get :choose_entry, :id => chef.id
      expect(response).to be_successful
    end
  end

  describe "POST #destroy_entry" do
    it "deletes a chef's entry" do
      chef = Chef.create!(valid_attributes)
      post :destroy_entry, :id => chef.id, :new_entry => { day: 'Monday' }
      chef.reload
      expect(chef.schedule).not_to include('Monday')
      expect(chef.days).not_to include('Monday')
      expect(chef.max_customers).not_to include('Monday')
      expect(flash[:notice]).to be_present
      expect(response).to redirect_to(chef_path(chef))
    end

    it "handles non-existing entries" do
      chef = Chef.create!(valid_attributes)
      post :destroy_entry, :id => chef.id, :new_entry => { day: 'NonExistentDay' }
      expect(flash[:notice]).to eq('No such entry exists')
      expect(response).to redirect_to(chef_path(chef))
    end
  end

  # Add more tests for the 'destroy' action as needed
end
