class ChefinfosController < ApplicationController
  before_action :authenticate_chef!, only: [:show, :edit, :update, :choose_entry, :see_meal, :destroy_entry]

  def show
    id = params[:id] # retrieve movie ID from URI route
    @chefinfo = Chefinfo.find(id) # look up movie by unique ID
    @chefmeals = @chefinfo.chefmeals
    #will render app/views/chefs/show.<extension> by default
  end

  def edit
    @chefinfo = Chefinfo.find params[:id]
  end

  def update
    #add all intermediate steps
    @chefinfo = Chefinfo.find params[:id]
    if @chefinfo.subscription == params[:subscription] && params[:new_entry][:meal]!=""
      flash[:notice] = "Your info was successfully updated!"
      Chefmeal.create!({meal: params[:new_entry][:meal], mealtime: params[:mealtime] ,days: params[:day], max_customers: params[:new_entry][:max_customers], num_customers: 0, chefinfo_id: params[:id], username: @chefinfo.username})
    elsif @chefinfo.subscription != params[:subscription] 
      flash[:notice] = "Subscription availability updated!"
      @chefinfo.update_attribute(:subscription, params[:subscription])
    else
      flash[:notice] = "No changes entered."

    end
    redirect_to chefinfo_path(@chefinfo)
  end

  def choose_entry
    @chefinfo = Chefinfo.find params[:id]
    @chefmeals = @chefinfo.chefmeals
  end

  def see_meal
    @id = params[:id]
    @chefmeal = Chefmeal.find_by(id: @id)
    @customers = Chefmeal.get_customers_per_chefmeal_via_username(@chefmeal)
    @customer_info = []
    @customers.each do |every_customer|
      @customer_info.append(Customerinfo.find_by(username: every_customer))
    end
  end

  def destroy_entry
    @chefinfo = Chefinfo.find params[:id]
    @chefmeals = @chefinfo.chefmeals
    puts params
    meal_to_delete = @chefmeals.find_by(days: params[:day], mealtime: params[:mealtime])
    if meal_to_delete.blank?
      flash[:notice] = "No such entry exists"
      redirect_to chefinfo_path(@chefinfo)
    else
      meal_to_delete.delete
      flash[:notice] = "Your entry was successfully deleted!"
      redirect_to chefinfo_path(@chefinfo)
    end
  end

  def authenticate_chef!
    @chefinfo = Chefinfo.find params[:id]
    redirect_to root_path, notice: 'You are not authorized to access this page.' unless session[:chef_username].present? && session[:chef_username] == @chefinfo.username
  end
end
