require "test_helper"

class QuestionsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @question = questions(:one)
  end

  test "should get index" do
    get questions_url
    assert_response :success
  end

  test "should get new" do
    get new_question_url
    assert_response :success
  end

  test "should create question" do
    assert_difference('Question.count') do
      post questions_url, params: { question: { ch1: @question.ch1, ch10: @question.ch10, ch2: @question.ch2, ch3: @question.ch3, ch4: @question.ch4, ch5: @question.ch5, ch6: @question.ch6, ch7: @question.ch7, ch8: @question.ch8, ch9: @question.ch9, correct: @question.correct, query: @question.query, test_id: @question.test_id } }
    end

    assert_redirected_to question_url(Question.last)
  end

  test "should show question" do
    get question_url(@question)
    assert_response :success
  end

  test "should get edit" do
    get edit_question_url(@question)
    assert_response :success
  end

  test "should update question" do
    patch question_url(@question), params: { question: { ch1: @question.ch1, ch10: @question.ch10, ch2: @question.ch2, ch3: @question.ch3, ch4: @question.ch4, ch5: @question.ch5, ch6: @question.ch6, ch7: @question.ch7, ch8: @question.ch8, ch9: @question.ch9, correct: @question.correct, query: @question.query, test_id: @question.test_id } }
    assert_redirected_to question_url(@question)
  end

  test "should destroy question" do
    assert_difference('Question.count', -1) do
      delete question_url(@question)
    end

    assert_redirected_to questions_url
  end
end
