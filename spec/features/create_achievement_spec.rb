require 'rails_helper'

feature "create new achievements", type: :feature do

  before do 
  	visit ('/')
  	click_on('New Achievement')
  end

  scenario 'create new achievement with valid data' do 
  	fill_in('Title', with: 'Read a book')
  	fill_in('Description', with: 'Excellent read')
  	select('Public', from: 'Privacy')
  	check('Featured achievement')
  	attach_file('Cover image', "#{Rails.root}/spec/fixtures/cover_image.jpg")
  	click_on('Create Achievement')

  	expect(page).to have_content('Achievement has been created')
  	expect(Achievement.last.title).to eq('Read a book')
  end

  scenario 'cannot create achievement with invalid data' do
    click_on('Create Achievement')
    expect(page).to have_content("can't be blank")
  end
end
