require "rails_helper"
require_relative Rails.root.join('spec', 'support', 'context', 'test_context.rb')

RSpec.feature "Static elements/view", :type => :feature do
  include_context 'test_context'

  before(:all) do
    binding.pry
    @user1 = create(:user)
  end

  scenario "User NOT logged in" do
    binding.pry
    go_to_base_page
  end
end