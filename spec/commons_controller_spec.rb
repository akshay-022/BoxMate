require 'rails_helper'

RSpec.describe CommonsController, type: :controller do
  describe 'GET #signIn' do
    it 'renders the signIn template' do
      get :signIn
      expect(response).to render_template('signIn')
    end

    it 'assigns @commons' do
      get :signIn
      expect(assigns(:commons)).to be_an(ActiveRecord::Relation)
    end
  end

  describe 'POST #signin_intermediate' do
    context 'when the user is a Chef' do
      chef = Chef.create!({username: 'testchef', password: 'password123'})

      it 'redirects to the chef profile page on successful login' do
        post :signin_intermediate, :common => { username: chef.username, password: chef.password }
        expect(response).to redirect_to(chef_path(chef))
      end

      it 'redirects to the signIn page with invalid password' do
        post :signin_intermediate, :common => { username: chef.username, password: 'wrong_password' }
        expect(flash[:notice]).to eq('Invalid password')
        expect(response).to redirect_to(commons_path)
      end

      it 'redirects to the signIn page with invalid username' do
        post :signin_intermediate, :common => { username: 'randomchef', password: chef.password }
        expect(flash[:notice]).to eq('Invalid username')
        expect(response).to redirect_to(commons_path)
      end
    end

    context 'when the user is a Customer' do
      customer = Customer.create!({ username: 'testcustomer', password: 'password123'})

      it 'redirects to the customer profile page on successful login' do
        post :signin_intermediate, :common => { username: customer.username, password: customer.password }
        expect(response).to redirect_to(customer_path(customer))
      end

      it 'redirects to the signIn page with invalid password' do
        post :signin_intermediate, :common => { username: customer.username, password: 'wrong_password' }
        expect(flash[:notice]).to eq('Invalid password')
        expect(response).to redirect_to(commons_path)
      end

      it 'redirects to the signIn page with invalid username' do
        post :signin_intermediate, :common => { username: 'invalid_user', password: customer.password }
        expect(flash[:notice]).to eq('Invalid username')
        expect(response).to redirect_to(commons_path)
      end
    end
  end
end
