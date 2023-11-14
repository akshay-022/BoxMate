class CustomerinfosController < ApplicationController
  before_action :authenticate_customer!, only: [:show, :edit, :update, :choose_entry, :destroy_entry]

  def show
    id = params[:id] # retrieve customer ID from URI route
    @customerinfo = Customerinfo.find(id) # look up customer by unique ID
    @days, @mealtimes, @chefs, @meals = Customerinfo.get_customer_meal_details(@customerinfo)
    #will render app/views/customers/show.<extension> by default
  end

  def edit
    id = params[:id] # retrieve customer ID from URI route
    @customerinfo = Customerinfo.find(id)
    @chefs_table = Chefmeal.all
    if @customerinfo
      @days, @mealtimes, @chefs, @meals = Customerinfo.get_customer_meal_details(@customerinfo)
      @all_cuisines = Customermeal.all_cuisines
    else
      flash[:notice] = "Customer not found"
      redirect_to customerinfos_path # Redirect to the index page or handle as appropriate
    end
  end

  def update
    #add all intermediate steps
    @customerinfo = Customerinfo.find params[:id]
    @days, @mealtimes, @chefs, @meals = Customerinfo.get_customer_meal_details(@customerinfo)
    @chefinfo = Chefinfo.find_by(name: params[:new_entry][:chef])
    if @chefinfo.blank?
      flash[:notice] = "This chef does not exist!"
    elsif @chefinfo.chefmeals.find_by(days: params[:day]).blank?
      flash[:notice] = "This chef does not cook on this day!"
    else
      chef_name = params[:new_entry][:chef]
      day_needed = params[:day]
      customer = {:customerinfo_id => @customerinfo.id, :chefmeal_id => @chefinfo.chefmeals.find_by(days: params[:day]).id ,:username => @customerinfo.username}
      Customermeal.create!(customer)
      Chefmeal.update_num_customers(params[:new_entry][:chef], params[:day], 1) #1 to add an entry, -1 to delete an entry
      flash[:notice] = "Your choice was successfully updated!"
    end
    redirect_to customerinfo_path(@customerinfo)
  end

  def choose_entry
    id = params[:id] # retrieve customer ID from URI route
    @customerinfo = Customerinfo.find(id) # look up movie by unique ID
    @days, @mealtimes, @chefs, @meals = Customerinfo.get_customer_meal_details(@customerinfo)
  end

  def destroy_entry
    @customerinfo = Customerinfo.find params[:id]
    @days, @mealtimes, @chefs, @meals = Customerinfo.get_customer_meal_details(@customerinfo)
    day_and_meal = @days.zip(@mealtimes)
    our_index = day_and_meal.find_index([params[:day], params[:mealtime]])
    if our_index.blank?
      flash[:notice] = "No such entry exists"
      redirect_to customerinfo_path(@customerinfo)
    else
      Chefmeal.update_num_customers(@chefs[our_index], params[:day], -1) #1 to add an entry, -1 to delete an entry
      @customerinfo.customermeals[our_index].delete
      flash[:notice] = "Your entry was successfully deleted!"
      redirect_to customerinfo_path(@customerinfo)
    end
  end

  def authenticate_customer!
    @customerinfo = Customerinfo.find params[:id]
    redirect_to root_path, notice: 'You are not authorized to access this page.' unless session[:customer_username].present? && session[:customer_username] == @customerinfo.username
  end
end
  