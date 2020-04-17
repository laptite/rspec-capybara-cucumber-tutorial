class AchievementsController < ApplicationController
  before_action :find_achievement, only: [:show, :edit, :update, :destroy]

  def index
    @achievements = Achievement.global_access.order(created_at: :desc)    
  end

  def new
    @achievement = Achievement.new
  end

  def create
    @achievement = Achievement.new(achievement_params)
    if @achievement.save
      redirect_to achievement_path(@achievement), notice: 'Achievement has been created'
    else
      render :new
    end
  end

  def show
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
    redirect_to root_path
  end

  private

    def achievement_params
      params.require(:achievement).permit(:title, :description, :privacy, :featured, :cover_image)
    end

    def find_achievement
      @achievement = Achievement.find(params[:id])
    end

end