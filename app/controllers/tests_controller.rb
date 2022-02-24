class TestsController < ApplicationController
  before_action :set_test, only: [:show, :edit, :update, :destroy]
  before_action :require_login
  before_action :require_admin, except: [:index, :show]
  
  # GET /tests
  # GET /tests.json
  def index
    @tests = Test.all
    # @tests.order(:name)
  end

  # GET /tests/1
  # GET /tests/1.json
  def show
    @user = User.find(params[:id])
    @tests = Test.find(params[:name])
  end

  # GET /tests/new
  def new
    @users = User.all.where(isAdmin: true)
    @test = Test.new
  end

  # GET /tests/1/edit
  def edit
    @users = User.all.where(isAdmin: true)
    @user_options = @users.map{ |u| [u.firstName + " " + u.lastName, u.firstName ] }
    @questions = Question.all.where(test_id: @test.id)
  end

  # POST /tests
  # POST /tests.json
  def create
    @test = Test.new(test_params)
    respond_to do |format|
      if @test.save
        format.html { redirect_to new_test_question_path(:test_id=>@test.id) }
        format.json { render "questions/new", status: :created, location: new_test_question_path(:test_id=>@test.id) }
      else
        format.html { render :new }
        format.json { render json: @test.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /tests/1
  # PATCH/PUT /tests/1.json
  def update
    respond_to do |format|
      if @test.update(test_params)
        if params[:Add]
          format.html { redirect_to new_test_question_path(:test_id=>@test.id) }
          format.json { render "questions/new", status: :ok, location: new_test_question_path(:test_id=>@test.id) }
        elsif params[:Save]
          format.html { redirect_to home_url, notice: 'Test was successfully updated.' }
          format.json { render :index, status: :ok, location: home_url }
        elsif params[:Edit]
          format.html { redirect_to edit_test_question_path(params[:id]) }
          format.json { render "questions/edit", status: :ok, location: edit_test_question_path(params[:id]) }
        end
      else
        format.html { render :edit }
        format.json { render json: @test.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /tests/1
  # DELETE /tests/1.json
  def destroy
    @test.destroy
    respond_to do |format|
      format.html { redirect_to home_path, notice: 'Test was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_test
      @test = Test.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def test_params
      params.require(:test).permit(:name, :user_id, :private, :password, :time)
    end
end
