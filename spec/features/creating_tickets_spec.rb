require 'rails_helper'

RSpec.feature "User can create new tickets" do
  before do
    project = FactoryGirl.create(:project, name: "Internet Explorer")

    visit project_path(project)
    click_link "New Ticket"
  end

    scenario "with valid attributes" do
      fill_in "Name", with: "Non-standards compliances"
      fill_in "Description", with: "My pages are ulgy!"
      click_button "Create Ticket"

    expect(page).to have_content "Ticket has been created."
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
