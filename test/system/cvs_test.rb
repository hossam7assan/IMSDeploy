require "application_system_test_case"

class CvsTest < ApplicationSystemTestCase
  setup do
    @cv = cvs(:one)
  end

  test "visiting the index" do
    visit cvs_url
    assert_selector "h1", text: "Cvs"
  end

  test "creating a Cv" do
    visit cvs_url
    click_on "New Cv"

    fill_in "Path", with: @cv.path
    fill_in "Student", with: @cv.student_id
    click_on "Create Cv"

    assert_text "Cv was successfully created"
    click_on "Back"
  end

  test "updating a Cv" do
    visit cvs_url
    click_on "Edit", match: :first

    fill_in "Path", with: @cv.path
    fill_in "Student", with: @cv.student_id
    click_on "Update Cv"

    assert_text "Cv was successfully updated"
    click_on "Back"
  end

  test "destroying a Cv" do
    visit cvs_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Cv was successfully destroyed"
  end
end
