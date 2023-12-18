class ProfilesController < ApplicationController
  before_action :set_profile, only: [:show, :edit, :update, :destroy]

  # GET /profiles/1
  def show
    @customer_user = Customerinfo.find_by(username: session[:customer_username])
    @chef_user = Chefinfo.find_by(username: session[:chef_username])
    @chef =  Chefinfo.find_by(id: params[:id])
    @chefmeals = @chef.chefmeals
    @chef_reviews = @chef.chef_reviews
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_profile
      @profile = Chefinfo.find(params[:id])
    end
end
