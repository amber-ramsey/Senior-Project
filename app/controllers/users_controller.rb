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
    @people = User.all.order(:firstname)

    @users = @people.where(isAdmin: false)
    # @users = @users.order(:firstname)
    @admin = @people.where(isAdmin: true)
    # @admin = @admin.order(:firstname)
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

    respond_to do |format|
      if @user.valid?(:editable) && @user.valid?(:pword) && @user.save
        reset_session
        log_in(@user)
        format.html { redirect_to home_path }
        format.json { render "tests/index", status: :created, location: home_path }
      else
        format.html { render :new }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    if params[:Promote]
      respond_to do |format|
        if @user.update(:isAdmin => true)
          format.html { redirect_to users_list_path, notice: 'User was successfully updated.' }
          format.json { render :update, status: :ok, location: users_list_path }
        else
          format.html { render :index }
          format.json { render json: @user.errors, status: :unprocessable_entity }
        end
      end
    else
      # logger.debug "before: #{@user.attributes}\n"
      @user.assign_attributes(user_params)
      # logger.debug "after: #{@user.attributes}\n"
      # logger.debug "valid?: #{@user.valid?(:editable)}\n"
      respond_to do |format|
        if @user.valid?(:editable) && @user.save
          # logger.debug "user: #{@user.attributes}"
          format.html { redirect_to profile_path(id: current_user), notice: 'User was successfully updated.' }
          format.json { render :update, status: :ok, location: profile_path(id: current_user) }
        else
          format.html { render :edit }
          format.json { render json: @user.errors, status: :unprocessable_entity }
        end
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
      params.require(:user).permit(:firstName, :lastName, :email, :password, :password_digest, :password_confirmation, :schoolID, :isAdmin)
    end
end
