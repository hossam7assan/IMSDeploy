require "application_system_test_case"

class CoursesTracksTest < ApplicationSystemTestCase
  setup do
    @courses_track = courses_tracks(:one)
  end

  test "visiting the index" do
    visit courses_tracks_url
    assert_selector "h1", text: "Courses Tracks"
  end

  test "creating a Courses track" do
    visit courses_tracks_url
    click_on "New Courses Track"

    click_on "Create Courses track"

    assert_text "Courses track was successfully created"
    click_on "Back"
  end

  test "updating a Courses track" do
    visit courses_tracks_url
    click_on "Edit", match: :first

    click_on "Update Courses track"

    assert_text "Courses track was successfully updated"
    click_on "Back"
  end

  test "destroying a Courses track" do
    visit courses_tracks_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Courses track was successfully destroyed"
  end
end
