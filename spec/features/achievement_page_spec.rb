require 'rails_helper'

feature 'achievement page' do 
  scenario 'achievement global page' do 
    achievement = Achievement.create(title: 'Just did it')
    visit("achievements/#{achievement.id}")

    expect(page).to have_content('Just did it')
  end

  scenario 'render markdown description' do
    achievement = Achievement.create!(description: 'That *was* hard')
    visit("achievements/#{achievement.id}")

    expect(page).to have_content('<i>was</i>')
  end
end