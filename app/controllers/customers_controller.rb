class CustomersController < ApplicationController

  def show
    id = params[:id] # retrieve customer ID from URI route
    @customer = Customer.find(id) # look up customer by unique ID
    @days = @customer.days.split(",")
    @chefs = @customer.chefs.split(",")
    puts "Hello"
    puts "#{@days} was successfully created."
    @meals = Customer.find_dishes(@days, @chefs)

    
    #will render app/views/customers/show.<extension> by default
  end

  def edit
    id = params[:id] # retrieve customer ID from URI route
    @customer = Customer.find(id) # look up movie by unique ID
    @days = @customer.days.split(",")
    @chefs = @customer.chefs.split(",")
    @chefs_table = Chef.get_chefs_meals
    @meals = Customer.find_dishes(@days, @chefs)
    @all_cuisines = Customer.all_cuisines
  end

  def update
    #add all intermediate steps
    @customer = Customer.find params[:id]
    @chefs = @customer.chefs.split(",")
    @days = @customer.days.split(",")
    if Chef.find_by(name: params[:new_entry][:chef]).blank?
      flash[:notice] = "This entry does not exist!"
    else
      if Chef.find_by(name: params[:new_entry][:chef]).days.split(",").include?(params[:new_entry][:day])
        @chefs = @chefs.append(params[:new_entry][:chef])
        @days = @days.append(params[:new_entry][:day])
        @customer.chefs = @chefs*","
        @customer.days = @days*","
        @customer.save
        chef_here = Chef.update_num_customers(params[:new_entry][:chef], params[:new_entry][:day], 1) #1 to add an entry, -1 to delete an entry
        chef_here.save
        flash[:notice] = "Your choice was successfully updated!"
      else
        flash[:notice] = "This entry does not exist!"
      end
    end
    redirect_to customer_path(@customer)
  end

  def choose_entry
    id = params[:id] # retrieve customer ID from URI route
    @customer = Customer.find(id) # look up movie by unique ID
    @days = @customer.days.split(",")
    @chefs = @customer.chefs.split(",")
    @meals = Customer.find_dishes(@days, @chefs)
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
      chef_here = Chef.update_num_customers(@chefs[our_index], params[:new_entry][:day], -1) #1 to add an entry, -1 to delete an entry
      chef_here.save
      array_cust = chef_here.num_customers.split(",")
      @chefs.delete_at(our_index)
      @days.delete_at(our_index)
      @customer.chefs = @chefs*","
      @customer.days = @days*","
      @customer.save
      flash[:notice] = "Your entry was successfully deleted!"
      redirect_to customer_path(@customer)
    end
  end
end
  