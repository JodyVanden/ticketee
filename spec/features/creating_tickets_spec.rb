require 'rails_helper'

RSpec.feature "User can create new tickets" do
  let(:user){ FactoryGirl.create(:user)}

  before do
    login_as(user)
    project = FactoryGirl.create(:project, name: "Internet Explorer")

    visit project_path(project)
    click_link "New Ticket"
  end

    scenario "with valid attributes" do
      fill_in "Name", with: "Non-standards compliances"
      fill_in "Description", with: "My pages are ulgy!"
      click_button "Create Ticket"

    expect(page).to have_content "Ticket has been created."
      within("#ticket") do
        expect(page).to have_content "Author: #{user.email}"
      end
    end

    scenario "with non valid attributes" do
      click_button "Create Ticket"

      expect(page).to have_content "Ticket was not created."
      expect(page).to have_content "Namecan't be blank"
      expect(page).to have_content "Description can't be blank"
    end

    scenario "with a non valid description" do
      fill_in "Name", with: "Non-standards compliances"
      fill_in "Description", with: "it sucks"
      click_button "Create Ticket"

      expect(page).to have_content "Ticket was not created"
      expect(page).to have_content "Description it sucksis too short"
    end
  end
