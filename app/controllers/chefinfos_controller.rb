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
    if params[:new_entry][:meal]=="" || params[:day].blank? || params[:new_entry][:max_customers].blank?
      flash[:notice] = "Some fields missing."
    elsif params[:subscription]=="None" && params[:new_entry][:meal]!=""
      flash[:notice] = "Your info was successfully updated!"
      Chefmeal.create!({meal: params[:new_entry][:meal], mealtime: params[:mealtime] ,days: params[:day], max_customers: params[:new_entry][:max_customers], num_customers: 0, chefinfo_id: params[:id], username: @chefinfo.username})
    else
      flash[:notice] = "Your regular meals have been added!"
      increment_by = (params[:subscription] == "Daily") ? 1 : 7
      date_here = Date.parse(params[:day])
      for i in 1..5 do
        Chefmeal.create!({meal: params[:new_entry][:meal], mealtime: params[:mealtime] ,days: (date_here + increment_by*i).to_s, max_customers: params[:new_entry][:max_customers], num_customers: 0, chefinfo_id: params[:id], username: @chefinfo.username})
      end
    end
    redirect_to chefinfo_path(@chefinfo)
  end

  def choose_entry
    @chefinfo = Chefinfo.find params[:id]
    @chefmeals = @chefinfo.chefmeals
  end

  def see_meal
    @id = params[:chefmealid]
    @chefmeal = Chefmeal.find_by(id: @id)
    @customermeals = @chefmeal.customermeals
    @customer_info = []
    @customermeals.each do |every_customer|
      @customer_info.append(every_customer)
    end
  end

  def destroy_entry
    @chefinfo = Chefinfo.find params[:id]
    @chefmeal = @chefinfo.chefmeals.find params[:chefmealid]
    @chefmeal.delete
    flash[:notice] = "Your entry was successfully deleted!"
    redirect_to chefinfo_path(@chefinfo)
  end

  def authenticate_chef!
    @chefinfo = Chefinfo.find_by(id: params[:id])
    
    unless @chefinfo && session[:chef_username] == @chefinfo.username
      redirect_to root_path, notice: 'You are not authorized to access this page.'
    end
  end
end
