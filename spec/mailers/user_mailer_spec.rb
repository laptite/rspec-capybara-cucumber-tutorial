require "rails_helper"

RSpec.describe UserMailer, type: :mailer do
  include Rails.application.routes.url_helpers

  let(:email) { UserMailer.achievement_created('author@email.com', achievement_id).deliver_now }
  let(:achievement_id) { 1 }
  it 'sends achievement created email to author' do 
    expect(email.to).to include('author@email.com')
  end

  it 'has correct subject' do 
    expect(email.subject).to eq('Your new achievement has been successfully created')
  end

  it 'has achievement link in body message' do 
    expect(email.body.to_s).to include(achievement_url(achievement_id))
  end
end
