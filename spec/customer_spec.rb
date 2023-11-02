require 'rails_helper'

RSpec.describe CustomersController, type: :controller do
  describe 'GET #show' do
    it 'assigns the requested movie to @movie' do
      movie = Movie.create(title: 'Example Movie', rating: 'PG', description: 'blahblah', release_date: Date.today)
      get :show, params: { id: movie.id }
      expect(assigns(:movie)).to eq(movie)
    end

    it 'renders the :show template' do
      movie = Movie.create(title: 'Example Movie', rating: 'PG', description: 'blahblah', release_date: Date.today)
      get :show, params: { id: movie.id }
      expect(response).to render_template(:show)
    end
  end

  describe 'GET #index' do
    it 'assigns all movies to @movies' do
      movie1 = Movie.create(title: 'Example Movie 1', rating: 'PG', description: 'blahblah', release_date: Date.today)
      movie2 = Movie.create(title: 'Example Movie 2', rating: 'PG', description: 'blahblah', release_date: Date.today)

      get :index
      expect(assigns(:movies)).to match_array([movie1, movie2])
    end

    it 'renders the :index template' do
      get :index
      expect(response).to render_template(:index)
    end
  end

  describe 'GET #customer_homepage' do
    it 'assigns all chefs to @chefs and all cuisines to @all_cuisines' do
      chef1 = Chef.create(name: 'Chef 1', cuisine: 'Italian')
      chef2 = Chef.create(name: 'Chef 2', cuisine: 'Mexican')

      get :customer_homepage
      expect(assigns(:chefs)).to match_array([chef1, chef2])
      expect(assigns(:all_cuisines)).to match_array(['Italian', 'Mexican'])
    end

    it 'renders the :customer_homepage template' do
      get :customer_homepage
      expect(response).to render_template(:customer_homepage)
    end
  end

  describe 'GET #new' do
    it 'renders the :new template' do
      get :new
      expect(response).to render_template(:new)
    end
  end

  describe 'POST #create' do
    it 'creates a new movie and sets flash notice and redirects to movies_path' do
      valid_params = { title: 'Example Movie', rating: 'PG', description: 'blahblah', release_date: Date.today }
      post :create, params: { movie: valid_params }

      expect(Movie.count).to eq(1)
      expect(flash[:notice]).to eq('Example Movie was successfully created.')
      expect(response).to redirect_to(movies_path)
    end
  end

  describe 'GET #edit' do
    it 'assigns the requested movie to @movie' do
      movie = Movie.create(title: 'Example Movie', rating: 'PG', description: 'blahblah', release_date: Date.today)
      get :edit, params: { id: movie.id }
      expect(assigns(:movie)).to eq(movie)
    end

    it 'renders the :edit template' do
      movie = Movie.create(title: 'Example Movie', rating: 'PG', description: 'blahblah', release_date: Date.today)
      get :edit, params: { id: movie.id }
      expect(response).to render_template(:edit)
    end
  end

  describe 'PATCH #update' do
    it 'updates the movie and sets flash notice and redirects to movie_path(@movie)' do
      movie = Movie.create(title: 'Example Movie', rating: 'PG', description: 'blahblah', release_date: Date.today)
      updated_params = { title: 'Updated Movie', rating: 'PG-13' }

      patch :update, params: { id: movie.id, movie: updated_params }

      movie.reload
      expect(movie.title).to eq('Updated Movie')
      expect(movie.rating).to eq('PG-13')
      expect(flash[:notice]).to eq('Updated Movie was successfully updated.')
      expect(response).to redirect_to(movie_path(movie))
    end
  end

  describe 'DELETE #destroy' do
    it 'destroys the movie and sets flash notice and redirects to movies_path' do
      movie = Movie.create(title: 'Example Movie', rating: 'PG', description: 'blahblah', release_date: Date.today)

      delete :destroy, params: { id: movie.id }

      expect(Movie.count).to eq(0)
      expect(flash[:notice]).to eq("Movie 'Example Movie' deleted.")
      expect(response).to redirect_to(movies_path)
    end
  end
end
