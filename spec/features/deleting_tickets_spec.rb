require "rails_helper"

RSpec.feature "Delete Tickets" do
  let(:author) { FactoryGirl.create(:user) }
  let(:project) { FactoryGirl.create(:project) }
  let(:ticket)  { FactoryGirl.create(:ticket, project: project, author: author) }

  before do
    visit project_ticket_path(project, ticket)
  end

  scenario "successuly" do
    click_link "Delete Ticket"

    expect(page).to have_content "Ticket has been deleted."
    expect(page.current_url).to eq project_url(project)
  end


end
