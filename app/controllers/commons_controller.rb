

class CommonsController < ApplicationController

  def signIn
    @commons = Common.all
  end

  def signin_intermediate
    #flash[:notice]= "Movie '#{params[:common][:username]}' deleted."
    user_chef = Chef.find_by(username: params[:common][:username])
    user_customer = Customer.find_by(username: params[:common][:username])
    if user_chef.blank?
      if user_customer.blank?
        flash[:notice]= "Invalid username"
        redirect_to commons_path
      else
        if user_customer.password == params[:common][:password]
          redirect_to customer_path(user_customer)
        else
          flash[:notice]= "Invalid password"
          redirect_to commons_path
        end
      end
    else
      if user_chef.password == params[:common][:password]
        redirect_to (chef_path(user_chef))
      else
        flash[:notice]= "Invalid password"
        redirect_to commons_path
      end
    end
  end

  private
  # Making "internal" methods private is not required, but is a common practice.
  # This helps make clear which methods respond to requests, and which ones do not.
  def movie_params
    params.require(:movie).permit(:title, :rating, :description, :release_date)
  end
end
