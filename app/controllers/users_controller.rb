class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]
  before_action :require_login, except: [:new, :create]
  before_action :require_admin, only: [:index, :destroy]

  # GET /users
  # GET /users.json
  def index
    # if params[:search]
    #   search_users
    # end
    @users = User.where(isAdmin: false).order(:firstName)
    @admin = User.where(isAdmin: true).order(:firstName)
  end

  # add will_paginate and search_users to helper file?
  # def will_paginate
  # end
  # be able to search by first, last, or both first and last name
  # def search_users
    # if @user == User.all.find{|user| user.name.include? (params[:search])}
    #   @user = User.all.find{|user| user.name.include? (params[:search])}
    # end
    # respond_to do |format|
    #   format.js {render inline: "location.reload();" }
    # end
  # end

  # GET /users/1
  # GET /users/1.json
  def show
    @user = User.find(params[:id])
  end

  # GET /users/new
  def new
    @user = User.new
  end

  # GET /users/1/edit
  def edit
  end

  # POST /users
  # POST /users.json
  def create
    @user = User.new(user_params)
    @user.isAdmin = false

    # respond_to do |format|
      if @user.save
        reset_session
        log_in @user
        redirect_to tests_path
      else
        format.html { render :new }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    # end
  end

  def update
    
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to users_url, notice: 'User was successfully updated.' }
        format.json { render :update, status: :ok, location: @user }
      else
        format.html { render :update }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    @user.destroy
    respond_to do |format|
      format.html { redirect_to users_url, notice: 'User was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def user_params
      params.require(:user).permit(:firstName, :lastName, :email, :password_digest, :password_confirmation, :schoolID, :isAdmin)
    end
end
