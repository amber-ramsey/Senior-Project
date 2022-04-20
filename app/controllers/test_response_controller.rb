class TestResponseController < ApplicationController
  before_action :set_response, only: [:destroy]

  def create
    @response = TestResponse.new(response_params)
    @question = Question.find(@response.question_id)
    if @response.response == @question.correct
      @score = TRUE
      # Rails.logger.debug("score: #{@score.inspect}")
    else
      @score = FALSE
      # Rails.logger.debug("score: #{@score.inspect}")
    end
    # Rails.logger.debug("if statement: #{@response.response} & #{@question.correct}")
    @response.left_at = "#{params[:left_at]}"
    @response.isCorrect = @score
    # Rails.logger.debug("isCorrect: #{@response.isCorrect}")
    # Rails.logger.debug("inspect: #{@response.inspect}")
    @end = "#{params[:end][0]}:#{params[:end][1]}:#{params[:end][2]}"
    # Rails.logger.debug("end: #{@end}")
    respond_to do |format|
      if @response.valid? && @response.save
        if params[:Submit]
          format.html { redirect_to home_path, notice: 'Question Response Saved.' }
        elsif params[:Next]
          format.html { redirect_to take_test_path(in_progress: true, start: @response.began_at, end: @end, id: @response.test_id, taken: "#{params[:taken]}"), notice: 'Question Response Saved.' }
        end
      else
        if params[:Submit]
          format.html { redirect_to home_path, notice: 'Time is up.' }
        else
          format.html { redirect_to take_test_path(in_progress: true, start: @response.began_at, end: @end, id: @response.test_id, taken: "#{(params[:taken].to_i)-1}"), notice: 'Question Response Not Saved.' }
          format.html { render "tests/show" }
          format.json { render json: @response.errors, status: :unprocessable_entity }
        end
      end
    end    
  end

  def destroy
    @response.destroy
    respond_to do |format|
      format.html { redirect_to home_path, notice: 'Response was successfully deleted.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_response
      @response = TestResponse.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def response_params
      params.require(:test_response).permit(:began_at, :left_at, :test_id, :question_id, :user_id, :response, :isCorrect)
    end
end
