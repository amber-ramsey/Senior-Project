class QuestionsController < ApplicationController
  before_action :set_question, only: [:show, :edit, :update, :destroy]

  # GET /questions
  # GET /questions.json
  def index
    @questions = Question.all
  end

  # GET /questions/1
  # GET /questions/1.json
  def show
  end

  # GET /questions/new
  def new
    @question = Question.new
  end

  # GET /questions/1/edit
  def edit
    @picture = @question.picture
    # logger.debug @question.attributes.inspect
  end

  # POST /questions
  # POST /questions.json
  def create
    @question = Question.new(question_params)
    @question.picture.attach(params[:question][:picture])
    respond_to do |format|
      if @question.save
        format.html { redirect_to edit_test_path(@question.test_id), notice: 'Question was successfully created.' }
      else
        format.html { render :new }
        format.json { render json: @question.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /questions/1
  # PATCH/PUT /questions/1.json
  def update
    # logger.debug @question.attributes.inspect
    @question.picture.attach(params[:question][:picture])
    respond_to do |format|
      if @question.update(question_params.except(:test_id))
        format.html { redirect_to edit_test_path(@question.test_id), notice: 'Question was successfully updated.' }
        format.json { render "tests/edit", status: :ok, location: edit_test_path(@question.test_id) }
      else
        format.html { render :edit }
        format.json { render json: @question.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /questions/1
  # DELETE /questions/1.json
  def destroy
    @id = @question.test_id
    @test = Test.find(@question.test_id)
    if (@test.questions.size >= 2) 
      @question.destroy
      respond_to do |format|
        format.html { redirect_to edit_test_path(@id), notice: 'Question was successfully deleted.' }
        format.json { head :no_content }
      end
    else 
      respond_to do |format|
        format.html { redirect_to edit_test_path(@id), notice: 'Question was not deleted. Test must have at least one question.' }
        format.json { render json: @question.errors, status: :bad_request }
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_question
      @question = Question.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def question_params
      params.require(:question).permit(:query, :ch1, :ch2, :ch3, :ch4, :ch4, :ch5, :ch6, :ch7, :ch8, :ch9, :ch10, :correct, :test_id, :picture)
    end
end
