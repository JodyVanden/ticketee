require "rails_helper"

RSpec.feature "User can view Tickets" do
  before do
    author = FactoryGirl.create(:user)
    sublime = FactoryGirl.create(:project, name: "Sublime Text")
    FactoryGirl.create(:ticket, project: sublime,
      name: "Make it Shiny!", description: "Gradiente! Starburats! Oh my!", author: author)

    ie = FactoryGirl.create(:project, name: "Internet Explorer")
    FactoryGirl.create(:ticket, project: ie,
      name: "Standart compliance", description: "Isn't a joke.")

    visit "/"
  end

  scenario "for a given project" do
    click_link "Sublime Text"

    expect(page).to have_content "Make it Shiny!"
    expect(page).to_not have_content  "Standart compliance"

    click_link "Make it Shiny!"
    within("#ticket h2") do
      expect(page).to have_content "Make it Shiny!"
    end

    expect(page).to have_content "Gradiente! Starburats! Oh my!"
  end
end
