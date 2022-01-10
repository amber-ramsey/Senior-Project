require "application_system_test_case"

class QuestionsTest < ApplicationSystemTestCase
  setup do
    @question = questions(:one)
  end

  test "visiting the index" do
    visit questions_url
    assert_selector "h1", text: "Questions"
  end

  test "creating a Question" do
    visit questions_url
    click_on "New Question"

    fill_in "Ch1", with: @question.ch1
    fill_in "Ch10", with: @question.ch10
    fill_in "Ch2", with: @question.ch2
    fill_in "Ch3", with: @question.ch3
    fill_in "Ch4", with: @question.ch4
    fill_in "Ch5", with: @question.ch5
    fill_in "Ch6", with: @question.ch6
    fill_in "Ch7", with: @question.ch7
    fill_in "Ch8", with: @question.ch8
    fill_in "Ch9", with: @question.ch9
    fill_in "Correct", with: @question.correct
    fill_in "Query", with: @question.query
    fill_in "Test", with: @question.test_id
    click_on "Create Question"

    assert_text "Question was successfully created"
    click_on "Back"
  end

  test "updating a Question" do
    visit questions_url
    click_on "Edit", match: :first

    fill_in "Ch1", with: @question.ch1
    fill_in "Ch10", with: @question.ch10
    fill_in "Ch2", with: @question.ch2
    fill_in "Ch3", with: @question.ch3
    fill_in "Ch4", with: @question.ch4
    fill_in "Ch5", with: @question.ch5
    fill_in "Ch6", with: @question.ch6
    fill_in "Ch7", with: @question.ch7
    fill_in "Ch8", with: @question.ch8
    fill_in "Ch9", with: @question.ch9
    fill_in "Correct", with: @question.correct
    fill_in "Query", with: @question.query
    fill_in "Test", with: @question.test_id
    click_on "Update Question"

    assert_text "Question was successfully updated"
    click_on "Back"
  end

  test "destroying a Question" do
    visit questions_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Question was successfully destroyed"
  end
end
