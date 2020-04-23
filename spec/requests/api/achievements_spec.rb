require 'rails_helper'

RSpec.describe 'Achievements API', type: :request do

  before { Achievement.destroy_all }
  
  it 'sends public achievements' do
    public_achievement  = create(:global_achievement, user: build(:user), title: "API achievement")
    private_achievement = create(:admin_achievement, user: build(:user))
    get '/api/achievements', params: { achievement: nil }, headers: { "Content-Type": "application/vnd.api+json"}, as: :json
    expect(response.status).to eq(200)
    json = JSON.parse(response.body)

    expect(json["data"].count).to eq(1)
    expect(json["data"][0]["type"]).to eq("achievements")
    expect(json["data"][0]["attributes"]["title"]).to eq("API achievement")
  end
end