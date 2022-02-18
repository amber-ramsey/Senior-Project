require "test_helper"

class ProjectDocumentationControllerTest < ActionDispatch::IntegrationTest
  test "should get test_plan" do
    get project_documentation_test_plan_url
    assert_response :success
  end
end
