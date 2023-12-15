class ChefinfosController < ApplicationController
  before_action :authenticate_chef!, only: [:show, :edit, :update, :choose_entry, :see_meal, :destroy_entry]

  def show
    id = params[:id] # retrieve movie ID from URI route
    @chefinfo = Chefinfo.find(id) # look up movie by unique ID
    @chefmeals = @chefinfo.chefmeals
    @subscriptions = Subscription.where(chefinfo_id: id)
    #will render app/views/chefs/show.<extension> by default
  end

  def edit
    @chefinfo = Chefinfo.find params[:id]
    @customer_username = session[:customer_username]
  end


  def create_chef_review
    @chef = Chefinfo.find(params[:id])
    @chef_review = ChefReview.new(chefinfo: @chef)
    chef_review_params[:customerinfo_id] = params[:customerinfo_id].to_i
    @chef_review = ChefReview.new(chef_review_params)
    if @chef_review.save
      flash[:notice] = "Review successfully submitted."
      redirect_to profile_path(id: @chef.id)
    else
      flash[:notive] = "Error: Unable to submit the review."
      redirect_to profile_path(id: @chef.id)
    end
  end

  def update
    #add all intermediate steps
    @chefinfo = Chefinfo.find params[:id]
    @subscriptions = Subscription.where(chefinfo_id: @chefinfo.id)
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
        total_customers = 0
        new_meal = Chefmeal.create!({meal: params[:new_entry][:meal], mealtime: params[:mealtime] ,days: (date_here + increment_by*i).to_s, max_customers: params[:new_entry][:max_customers], num_customers: 0, chefinfo_id: params[:id], username: @chefinfo.username})
        if @subscriptions
          @subscriptions.each do |subscriber|
            customer = Customerinfo.find_by(id: subscriber.customerinfo_id)
            Customermeal.create!(username: customer.username, chefmeal_id: new_meal.id, customerinfo_id: customer.id, num_meals: 1)
            total_customers += 1
          end
          new_meal.update_attribute(:num_customers, total_customers)
        end
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


  private

  # Strong parameters for ChefReview
  def chef_review_params
    params.require(:chef_review).permit(:content, :rating, :chefinfo_id, :customerinfo_id)
  end
end
