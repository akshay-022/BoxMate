class ChefinfosController < ApplicationController

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
end
