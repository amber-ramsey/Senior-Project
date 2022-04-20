class TestsController < ApplicationController
  before_action :set_test, only: [:result, :show, :edit, :update, :destroy]
  before_action :require_login
  before_action :require_admin, except: [:index, :show]
  
  # GET /tests
  # GET /tests.json
  def index
    if params[:results]
      # @taken_id = TestResponse.select(:test_id, :begin).distinct.where(:user_id == @user)
      # @taken_join = Test.joins(:response).where()
      # @take = TestResponse.distinct.pluck(:test_id, :begin).where(:user_id = @user.id)
      # @takens = TestResponse.select(:test_id, :begin).distinct.where(:user_id = @user.id)
      # @taken = Test.all.where(id: @taken_id.test_id)
    else
      @tests = Test.all
    end
  end

  # GET /tests_results
  # GET /tests_results.json
  def result_index
    @tests = Test.all
    # @tests.order(:name)
  end

  # GET /tests_results/1
  # GET /tests_results/1.json
  def result

  end

  # take test
  # GET /tests/1
  # GET /tests/1.json
  def show
    if params[:in_progress]
      @in_progress = params[:in_progress]
    end
    if @in_progress == "true"
      @test_response = TestResponse.new
      @start = params[:start]
      @end = params[:end].split(":")
      @array = []
      @test_quests = @test.questions
      # Rails.logger.debug("test_quests: #{@test_quests.inspect}")
      @i = 0
      @test_quests.find_each do |quest|
        @array[@i] = quest
        # Rails.logger.debug("array: #{@array.inspect}")
        @i = @i + 1
      end
      @question = @array[params[:taken].to_i]
      # Rails.logger.debug("current: #{@current.inspect}")
      # Rails.logger.debug("current attributes: #{@current.attributes}")
      # @qu = Question.where(test_id: @test.id)
      # Rails.logger.debug("questions: #{@qu.inspect}")
      # @try = @qu[(@taken.to_i)]
      # Rails.logger.debug("try: #{@try.inspect}")
      # @questions = Question.where(test_id: @test.id).limit(@taken).last
      # Rails.logger.debug("questions: #{@questions.inspect}")
      # @question = Question.where(test_id: @test.id).offset(@taken).first
      # Rails.logger.debug("question: #{@question.inspect}")
      @hash = @question.attributes
      # Rails.logger.debug("hash: #{@hash.inspect}")
      @taken = params[:taken].to_i + 1
    else
      @taken = 0
    end
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
    quest = params[:test][:quest_id]
    quest.to_i
    # logger.debug "Test: #{params[:test][:quest_id].inspect}"  .display
    respond_to do |format|
      if @test.update(test_params.except(:quest_id))
        if params[:Add]
          format.html { redirect_to new_test_question_path(:test_id=>@test.id) }
          format.json { render "questions/new", status: :ok, location: new_test_question_path(:test_id=>@test.id) }
        elsif params[:Save]
          format.html { redirect_to home_url, notice: 'Test was successfully updated.' }
          format.json { render :index, status: :ok, location: home_url }
        elsif params[:Edit]
          format.html { redirect_to edit_test_question_path(quest, :test_id=>@test.id) }
          format.json { render "questions/edit", status: :ok, location: edit_test_question_path(quest, :test_id=>@test.id) }
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
      params.require(:test).permit(:name, :user_id, :private, :password, :time, :description, :quest_id)
    end
end
