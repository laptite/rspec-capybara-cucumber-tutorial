require 'rails_helper'
require_relative '../support/new_achievement_form'

feature "create new achievements", type: :feature do
  let(:new_achievement_form) { NewAchievementForm.new }
  let(:user) { create(:user) }
  before { sign_in user}

  scenario 'create new achievement with valid data' do 
    
    new_achievement_form.visit_page.fill_in_with(
      title: 'Read a book',
      cover_image: 'cover_image.jpg'
    ).submit
    expect(ActionMailer::Base.deliveries.count).to eq(1)
    expect(ActionMailer::Base.deliveries.last.to).to include(user.email)
  	expect(page).to have_content('Achievement has been created')
  	expect(Achievement.last.title).to eq('Read a book')
    expect(Achievement.last.cover_image.attached?).to be_truthy
    # expect(page).to have_content("We tweeted for you https://twitter.com")
  end

  scenario 'cannot create achievement with invalid data' do
    new_achievement_form.visit_page.submit

    expect(page).to have_content("can't be blank")
  end
end
