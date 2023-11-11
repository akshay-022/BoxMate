class CustomerinfosController < ApplicationController

  def show
    id = params[:id] # retrieve customer ID from URI route
    @customerinfo = Customerinfo.find(id) # look up customer by unique ID
    @days, @chefs, @meals = Customerinfo.get_customer_meal_details(@customerinfo)
    #will render app/views/customers/show.<extension> by default
  end

  def edit
    id = params[:id] # retrieve customer ID from URI route
    @customerinfo = Customerinfo.find(id)
    @chefs_table = Chefmeal.all
    if @customerinfo
      @days, @chefs, @meals = Customerinfo.get_customer_meal_details(@customerinfo)
      @all_cuisines = Customermeal.all_cuisines
    else
      flash[:notice] = "Customer not found"
      redirect_to customerinfos_path # Redirect to the index page or handle as appropriate
    end
  end

  def update
    #add all intermediate steps
    @customerinfo = Customerinfo.find params[:id]
    @days, @chefs, @meals = Customerinfo.get_customer_meal_details(@customerinfo)
    @chefinfo = Chefinfo.find_by(name: params[:new_entry][:chef])
    if @chefinfo.blank?
      flash[:notice] = "This chef does not exist!"
    elsif @chefinfo.chefmeals.find_by(days: params[:new_entry][:day]).blank?
      flash[:notice] = "This chef does not cook on this day!"
    else
      chef_name = params[:new_entry][:chef]
      day_needed = params[:new_entry][:day]
      customer = {:customerinfo_id => @customerinfo.id, :chefmeal_id => @chefinfo.chefmeals.find_by(days: params[:new_entry][:day]).id ,:username => @customerinfo.username}
      Customermeal.create!(customer)
      Chefmeal.update_num_customers(params[:new_entry][:chef], params[:new_entry][:day], 1) #1 to add an entry, -1 to delete an entry
      flash[:notice] = "Your choice was successfully updated!"
    end
    redirect_to customerinfo_path(@customerinfo)
  end

  def choose_entry
    id = params[:id] # retrieve customer ID from URI route
    @customerinfo = Customerinfo.find(id) # look up movie by unique ID
    @days, @chefs, @meals = Customerinfo.get_customer_meal_details(@customerinfo)
  end

  def destroy_entry
    @customerinfo = Customerinfo.find params[:id]
    @days, @chefs, @meals = Customerinfo.get_customer_meal_details(@customerinfo)
    our_index = @days.find_index(params[:new_entry][:day])
    if our_index.blank?
      flash[:notice] = "No such entry exists"
      redirect_to customerinfo_path(@customerinfo)
    else
      Chefmeal.update_num_customers(@chefs[our_index], params[:new_entry][:day], -1) #1 to add an entry, -1 to delete an entry
      @customers[our_index].delete
      flash[:notice] = "Your entry was successfully deleted!"
      redirect_to customerinfo_path(@customerinfo)
    end
  end
end
  