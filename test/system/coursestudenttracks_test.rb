require "application_system_test_case"

class CoursestudenttracksTest < ApplicationSystemTestCase
  setup do
    @coursestudenttrack = coursestudenttracks(:one)
  end

  test "visiting the index" do
    visit coursestudenttracks_url
    assert_selector "h1", text: "Coursestudenttracks"
  end

  test "creating a Coursestudenttrack" do
    visit coursestudenttracks_url
    click_on "New Coursestudenttrack"

    click_on "Create Coursestudenttrack"

    assert_text "Coursestudenttrack was successfully created"
    click_on "Back"
  end

  test "updating a Coursestudenttrack" do
    visit coursestudenttracks_url
    click_on "Edit", match: :first

    click_on "Update Coursestudenttrack"

    assert_text "Coursestudenttrack was successfully updated"
    click_on "Back"
  end

  test "destroying a Coursestudenttrack" do
    visit coursestudenttracks_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Coursestudenttrack was successfully destroyed"
  end
end
