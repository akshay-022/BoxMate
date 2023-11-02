class CustomersController < ApplicationController

  def show
    id = params[:id] # retrieve customer ID from URI route
    @customer = Customer.find(id) # look up customer by unique ID
    @days = @customer.days.split(",")
    @chefs = @customer.chefs.split(",")
    @meals = Customer.find_dishes(@days, @chefs)
    #flash[:notice] = "#{@customer.chefs} was successfully created."
    #will render app/views/customers/show.<extension> by default
  end

  def edit
    #id = params[:id] # retrieve customer ID from URI route
    #@customer = customer.find(id) # look up movie by unique ID
    #@days = @customer.days.split(",")
    #@chefs = @customer.chefs.split(",")
    #@meals = Customer.find_dishes(@days, @chefs)
  end

  def update
    #add all intermediate steps
    @customer = Customer.find params[:id]
    @chefs = @customer.chefs.split(",")
    @days = @customer.days.split(",")
    @chefs = @chefs.append(params[:new_entry][:chefs])
    @days = @days.append(params[:new_entry][:day])
    @customer.chefs = @chefs*","
    @customer.days = @days*","
    @customer.save
    flash[:notice] = "Your choice was successfully updated!"
    redirect_to customer_path(@customer)
  end

  def choose_entry
    #id = params[:id] # retrieve customer ID from URI route
    #@customer = customer.find(id) # look up movie by unique ID
    #@days = @customer.days.split(",")
    #@chefs = @customer.chefs.split(",")
    #@meals = Customer.find_dishes(@days, @chefs)
  end

  def destroy_entry
    @customer = Customer.find params[:id]
    @chefs = @customer.chefs.split(",")
    @days = @customer.days.split(",")
    @meals = Customer.find_dishes(@days, @chefs)
    our_index = @days.find_index(params[:new_entry][:day])
    if our_index.blank?
      flash[:notice] = "No such entry exists"
      redirect_to customer_path(@customer)
    else
      @chefs.delete_at(our_index)
      @days.delete_at(our_index)
      @customer.chefs = @chefs*","
      @customer.days = @days*","
      @customer.save
      flash[:notice] = "Your entry was successfully deleted!"
      redirect_to customer_path(@customer)
    end
  end

  private
  # Making "internal" methods private is not required, but is a common practice.
  # This helps make clear which methods respond to requests, and which ones do not.
  def movie_params
    params.require(:movie).permit(:title, :rating, :description, :release_date)
  end
end
  