require 'rails_helper'

feature "achievement page" do 
  scenario "achievement global page" do 
    achievement = create(:achievement, title: "Just did it")
    visit("achievements/#{achievement.id}")

    expect(page).to have_content("Just did it")
  end

  scenario "render markdown description" do
    achievement = create(:achievement, description: "That *was* hard")
    visit("achievements/#{achievement.id}")

    expect(page.html).to include('That <em>was</em> hard')
    expect(page).to have_css('em', text: 'was')
  end
end