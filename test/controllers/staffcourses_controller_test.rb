require 'test_helper'

class StaffcoursesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @staffcourse = staffcourses(:one)
  end

  test "should get index" do
    get staffcourses_url
    assert_response :success
  end

  test "should get new" do
    get new_staffcourse_url
    assert_response :success
  end

  test "should create staffcourse" do
    assert_difference('Staffcourse.count') do
      post staffcourses_url, params: { staffcourse: {  } }
    end

    assert_redirected_to staffcourse_url(Staffcourse.last)
  end

  test "should show staffcourse" do
    get staffcourse_url(@staffcourse)
    assert_response :success
  end

  test "should get edit" do
    get edit_staffcourse_url(@staffcourse)
    assert_response :success
  end

  test "should update staffcourse" do
    patch staffcourse_url(@staffcourse), params: { staffcourse: {  } }
    assert_redirected_to staffcourse_url(@staffcourse)
  end

  test "should destroy staffcourse" do
    assert_difference('Staffcourse.count', -1) do
      delete staffcourse_url(@staffcourse)
    end

    assert_redirected_to staffcourses_url
  end
end
