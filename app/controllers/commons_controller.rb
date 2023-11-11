

class CommonsController < ApplicationController

  def signIn
    @commons = Common.all
  end

  def signin_intermediate
    #flash[:notice]= "Movie '#{params[:common][:username]}' deleted."
    user_chef = Chefinfo.find_by(username: params[:common][:username])
    user_customer = Customerinfo.find_by(username: params[:common][:username])
    if user_chef.blank?
      if user_customer.blank?
        flash[:notice]= "Invalid username"
        redirect_to commons_path
      else
        if user_customer.password == params[:common][:password]
          redirect_to customerinfo_path(user_customer)
        else
          flash[:notice]= "Invalid password"
          redirect_to commons_path
        end
      end
    else
      if user_chef.password == params[:common][:password]
        redirect_to (chefinfo_path(user_chef))
      else
        flash[:notice]= "Invalid password"
        redirect_to commons_path
      end
    end
  end
end
