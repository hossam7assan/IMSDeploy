require 'test_helper'

class CoursesTracksControllerTest < ActionDispatch::IntegrationTest
  setup do
    @courses_track = courses_tracks(:one)
  end

  test "should get index" do
    get courses_tracks_url
    assert_response :success
  end

  test "should get new" do
    get new_courses_track_url
    assert_response :success
  end

  test "should create courses_track" do
    assert_difference('CoursesTrack.count') do
      post courses_tracks_url, params: { courses_track: {  } }
    end

    assert_redirected_to courses_track_url(CoursesTrack.last)
  end

  test "should show courses_track" do
    get courses_track_url(@courses_track)
    assert_response :success
  end

  test "should get edit" do
    get edit_courses_track_url(@courses_track)
    assert_response :success
  end

  test "should update courses_track" do
    patch courses_track_url(@courses_track), params: { courses_track: {  } }
    assert_redirected_to courses_track_url(@courses_track)
  end

  test "should destroy courses_track" do
    assert_difference('CoursesTrack.count', -1) do
      delete courses_track_url(@courses_track)
    end

    assert_redirected_to courses_tracks_url
  end
end
