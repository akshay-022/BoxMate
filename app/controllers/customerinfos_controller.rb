class CustomerinfosController < ApplicationController
  before_action :authenticate_customer!, only: [:show, :edit, :update, :choose_entry, :destroy_entry]

  def show
    id = params[:id] # retrieve customer ID from URI route
    @customerinfo = Customerinfo.find(id) # look up customer by unique ID
    @days, @mealtimes, @chefs, @meals, @customermeal_ids = Customerinfo.get_customer_meal_details(@customerinfo)
    #will render app/views/customers/show.<extension> by default
  end

  def edit
    id = params[:id] # retrieve customer ID from URI route
    @customerinfo = Customerinfo.find(id)
    if (params[:cuisines] == nil && params[:sort] == nil) && (session[:cuisines] != nil || session[:sort] != nil)
      redirect_to(edit_customerinfo_path(sort: session[:sort], cuisines: session[:cuisines]))
    end
    session[:sort] = params[:sort] if params[:sort]
    session[:cuisines] = params[:cuisines] if params[:cuisines]

    params[:sort] ||= session[:sort]
    params[:cuisines] ||= session[:cuisines]
    @cuisines_to_show = params[:cuisines] ? params[:cuisines].keys  : (session[:cuisines] ? session[:cuisines] : Chefinfo.all_cuisines )
    @highlight_column = params[:sort] || session[:sort] || nil
    @chefs_table = Chefmeal.with_cuisines(@cuisines_to_show).order(@highlight_column)
    if @customerinfo
      @days, @mealtimes, @chefs, @meals, @customermeal_ids = Customerinfo.get_customer_meal_details(@customerinfo)
      @all_cuisines = Chefinfo.all_cuisines
    end
  end

  def update
    #add all intermediate steps
    @chef_meal_exist = false
    @customerinfo = Customerinfo.find params[:id]
    @days, @mealtimes, @chefs, @meals, @customermeal_ids = Customerinfo.get_customer_meal_details(@customerinfo)
    chefmeal_to_add = Chefmeal.find params[:chefmealid]
    customer = {:customerinfo_id => @customerinfo.id, :chefmeal_id => chefmeal_to_add.id ,:username => @customerinfo.username}
    Customermeal.create!(customer)
    chefmeal_to_add.num_customers += 1 #1 to add an entry, -1 to delete an entry
    chefmeal_to_add.save
    flash[:notice] = "Your choice was successfully updated!"
    @chef_meal_exist = true
    @chef_meal_exist ? redirect_to(customerinfo_path(@customerinfo)) : redirect_to(edit_customerinfo_path)
  end

  def choose_entry
    id = params[:id] # retrieve customer ID from URI route
    @customerinfo = Customerinfo.find(id) # look up movie by unique ID
    @days, @mealtimes, @chefs, @meals, @customermeal_ids = Customerinfo.get_customer_meal_details(@customerinfo)
  end

  def destroy_entry
    @customerinfo = Customerinfo.find params[:id]
    @customermeal = @customerinfo.customermeals.find params[:customermealid]
    @chefmeal = Chefmeal.find(@customermeal.chefmeal_id)
    @chefmeal.num_customers -= 1
    @chefmeal.save
    @customermeal.destroy
    flash[:notice] = "Your entry was successfully deleted!"
    redirect_to customerinfo_path(@customerinfo)
  end

  def authenticate_customer!
    @customerinfo = Customerinfo.find_by(id: params[:id])
    
    unless @customerinfo && session[:customer_username] == @customerinfo.username
      redirect_to root_path, notice: 'You are not authorized to access this page.'
    end
  end
end
  