class AchievementsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :edit, :update, :destroy]
  before_action :owners_only, only: [:edit, :update, :destroy]

  def index
    @achievements = Achievement.get_public_achievements
  end

  def new
    @achievement = Achievement.new
  end

  def create
    service = CreateAchievement.new(achievement_params, current_user)
    service.create
    @achievement = service.achievement
    if service.created?
      redirect_to achievement_path(@achievement), notice: 'Achievement has been created'
    else
      render :new
    end
  end

  def show
    @achievement = Achievement.find(params[:id])
  end

  def edit
  end

  def update
    if @achievement.update(achievement_params)
      redirect_to achievement_path(@achievement), notice: 'Achievement has been updated'
    else
      render :edit
    end
  end

  def destroy
    @achievement.destroy
    redirect_to achievements_path
  end

  private

    def achievement_params
      params.require(:achievement).permit(:title, :description, :privacy, :featured, :cover_image)
    end

    def find_achievement
      @achievement = Achievement.find(params[:id])
    end

    def owners_only
      @achievement = Achievement.find(params[:id])
      if current_user != @achievement.user
        redirect_to achievements_path
      end
    end

end