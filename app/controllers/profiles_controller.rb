class ProfilesController < ApplicationController
  before_action :set_profile, only: [:show, :edit, :update, :destroy]

  # GET /profiles
  # def index
  #   @profiles = Profile.all
  # end

  # GET /profiles/1
  def show
    @customer_user = Customerinfo.find_by(username: session[:customer_username])
    @chef_user = Chefinfo.find_by(username: session[:chef_username])
    @chef =  Chefinfo.find_by(id: params[:id])
    @chefmeals = @chef.chefmeals
    @chef_reviews = @chef.chef_reviews
  end

  # GET /profiles/new
  # def new
  #   @profile = Profile.new
  # end

  # GET /profiles/1/edit
  # def edit
  # end

  # POST /profiles
  # def create
  # end

  # DELETE /profiles/1
  # def destroy
  #   @profile.destroy
  #   redirect_to profiles_url, notice: 'Profile was successfully destroyed.'
  # end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_profile
      @profile = Chefinfo.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    # def profile_params
    #   params[:profile]
    # end
end
