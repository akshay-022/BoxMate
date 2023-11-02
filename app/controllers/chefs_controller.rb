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

  def choose_entry
    @chef = Chef.find params[:id]
    @schedule = @chef.schedule.split(",")
    @days = @chef.days.split(",")
    @address_coordinates = @chef.address_coordinates.split(",")
    @max_customers = @chef.max_customers.split(",")
    @num_customers = @chef.num_customers.split(",")
  end

  def destroy_entry
    @chef = Chef.find params[:id]
    @schedule = @chef.schedule.split(",")
    @days = @chef.days.split(",")
    @address_coordinates = @chef.address_coordinates.split(",")
    @max_customers = @chef.max_customers.split(",")
    @num_customers = @chef.num_customers.split(",")
    our_index = @days.find_index(params[:new_entry][:day])
    if our_index.blank?
      flash[:notice] = "No such entry exists"
      redirect_to chef_path(@chef)
    else
      @schedule.delete_at(our_index)
      @days.delete_at(our_index)
      @max_customers.delete_at(our_index)
      @num_customers.delete_at(our_index)
      @chef.schedule = @schedule*","
      @chef.days = @days*","
      @chef.max_customers = @max_customers*","
      @chef.num_customers = @num_customers*","
      @chef.save
      flash[:notice] = "Your entry was successfully deleted!"
      redirect_to chef_path(@chef)
    end
  end
end
