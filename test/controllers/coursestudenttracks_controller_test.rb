require 'test_helper'

class CoursestudenttracksControllerTest < ActionDispatch::IntegrationTest
  setup do
    @coursestudenttrack = coursestudenttracks(:one)
  end

  test "should get index" do
    get coursestudenttracks_url
    assert_response :success
  end

  test "should get new" do
    get new_coursestudenttrack_url
    assert_response :success
  end

  test "should create coursestudenttrack" do
    assert_difference('Coursestudenttrack.count') do
      post coursestudenttracks_url, params: { coursestudenttrack: {  } }
    end

    assert_redirected_to coursestudenttrack_url(Coursestudenttrack.last)
  end

  test "should show coursestudenttrack" do
    get coursestudenttrack_url(@coursestudenttrack)
    assert_response :success
  end

  test "should get edit" do
    get edit_coursestudenttrack_url(@coursestudenttrack)
    assert_response :success
  end

  test "should update coursestudenttrack" do
    patch coursestudenttrack_url(@coursestudenttrack), params: { coursestudenttrack: {  } }
    assert_redirected_to coursestudenttrack_url(@coursestudenttrack)
  end

  test "should destroy coursestudenttrack" do
    assert_difference('Coursestudenttrack.count', -1) do
      delete coursestudenttrack_url(@coursestudenttrack)
    end

    assert_redirected_to coursestudenttracks_url
  end
end
