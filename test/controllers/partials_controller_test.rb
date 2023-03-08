require "test_helper"

class PartialsControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get partials_new_url
    assert_response :success
  end

  test "should get edit" do
    get partials_edit_url
    assert_response :success
  end
end
