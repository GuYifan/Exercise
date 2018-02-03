require "rails_helper"

RSpec.feature "Static elements/view", :type => :feature do
  include_context 'test_context'

  scenario "User NOT logged in" do
    binding.pry
    go_to_base_page

    fill_in "Name", :with => "My Widget"
    click_button "Create Widget"

    expect(page).to have_text("Widget was successfully created.")
  end
end