require "application_system_test_case"

class StaffcoursesTest < ApplicationSystemTestCase
  setup do
    @staffcourse = staffcourses(:one)
  end

  test "visiting the index" do
    visit staffcourses_url
    assert_selector "h1", text: "Staffcourses"
  end

  test "creating a Staffcourse" do
    visit staffcourses_url
    click_on "New Staffcourse"

    click_on "Create Staffcourse"

    assert_text "Staffcourse was successfully created"
    click_on "Back"
  end

  test "updating a Staffcourse" do
    visit staffcourses_url
    click_on "Edit", match: :first

    click_on "Update Staffcourse"

    assert_text "Staffcourse was successfully updated"
    click_on "Back"
  end

  test "destroying a Staffcourse" do
    visit staffcourses_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Staffcourse was successfully destroyed"
  end
end
