

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
          session[:customer_username] = user_customer.username
          redirect_to customerinfo_path(user_customer)
        else
          flash[:notice]= "Invalid password"
          redirect_to commons_path
        end
      end
    else
      if user_chef.password == params[:common][:password]
        session[:chef_username] = user_chef.username
        redirect_to (chefinfo_path(user_chef))
      else
        flash[:notice]= "Invalid password"
        redirect_to commons_path
      end
    end
  end

  def signup_chef
    @commons = Common.all
  end

  def signup_customer
    @commons = Common.all
  end


  def signup_chef_intermediate
    #flash[:notice]= "Movie '#{params[:common][:username]}' deleted."
    user_chef = Chefinfo.find_by(username: params[:common][:username])
    if user_chef.blank?
      chefinfo = {username: params[:common][:username], password: params[:common][:password], name: params[:common][:name], address: params[:common][:address], address_coordinates: params[:common][:address_coordinates], tags: params[:common][:tags], food_constraint: params[:common][:food_constraint], description: params[:common][:description], subscription:params[:common][:subscription]}
      Chefinfo.create!(chefinfo)
      flash[:notice]= "Your profile was successfully created!!"
      redirect_to commons_path
    else
      flash[:notice]= "Username Taken :(("
      redirect_to commons_path
    end
  end


  def signup_customer_intermediate
    #flash[:notice]= "Movie '#{params[:common][:username]}' deleted."
    user_customer = Customerinfo.find_by(username: params[:common][:username])
    if user_customer.blank?
      customerinfo = {username: params[:common][:username], password: params[:common][:password], name: params[:common][:name], address: params[:common][:address], address_coordinates: params[:common][:address_coordinates], tags: params[:common][:tags], food_constraint: params[:common][:food_constraint], description: params[:common][:description]}
      Customerinfo.create!(customerinfo)
      flash[:notice]= "Your profile was successfully created!!"
      redirect_to commons_path
    else
      flash[:notice]= "Username Taken :(("
      redirect_to commons_path
    end
  end

  def destroy
    logged_in = (session[:chef_username].present? || session[:cutomer_username].present?) ? true : false
    session[:chef_username] = nil
    session[:customer_username] = nil
    redirect_to root_path, notice: logged_in ? 'Logged out successfully' : nil
  end


end
