class ChefsController < ApplicationController

  def show
    id = params[:id] # retrieve movie ID from URI route
    @chef = Chef.find(id) # look up movie by unique ID
    @schedule = @chef.schedule.split(",")
    @days = @chef.days.split(",")
    @address_coordinates = @chef.address_coordinates.split(",")
    @max_customers = @chef.max_customers.split(",")
    @num_customers = @chef.num_customers.split(",")
    #flash[:notice] = "#{@chef.schedule} was successfully created."
    #will render app/views/chefs/show.<extension> by default
  end

  def new
    # default: render 'new' template
  end

  def create
    @movie = Movie.create!(movie_params)
    flash[:notice] = "#{@movie.title} was successfully created."
    redirect_to movies_path
  end

  def edit
    @chef = Chef.find params[:id]
    @schedule = @chef.schedule.split(",")
    @days = @chef.days.split(",")
    @address_coordinates = @chef.address_coordinates.split(",")
    @max_customers = @chef.max_customers.split(",")
    @num_customers = @chef.num_customers.split(",")
  end

  def update
    #add all intermediate steps
    @chef = Chef.find params[:id]
    @schedule = @chef.schedule.split(",")
    @days = @chef.days.split(",")
    @address_coordinates = @chef.address_coordinates.split(",")
    @max_customers = @chef.max_customers.split(",")
    @num_customers = @chef.num_customers.split(",")
    @schedule = @schedule.append(params[:new_entry][:schedule])
    @days = @days.append(params[:new_entry][:day])
    @max_customers = @max_customers.append(params[:new_entry][:max_customers])
    @num_customers = @num_customers.append("0")
    @chef.schedule = @schedule*","
    @chef.days = @days*","
    @chef.max_customers = @max_customers*","
    @chef.num_customers = @num_customers*","
    @chef.save
    flash[:notice] = "Your info was successfully updated!"
    redirect_to chef_path(@chef)
  end

  def destroy
    @movie = Movie.find(params[:id])
    @movie.destroy
    flash[:notice] = "Movie '#{@movie.title}' deleted."
    redirect_to movies_path
  end

  private
  # Making "internal" methods private is not required, but is a common practice.
  # This helps make clear which methods respond to requests, and which ones do not.
  def movie_params
    params.require(:movie).permit(:title, :rating, :description, :release_date)
  end
end
