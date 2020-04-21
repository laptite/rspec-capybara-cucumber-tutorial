class Api::AchievementsController < ApiController

  def index
    achievements = Achievement.global_access
    render json: achievements
  end
end