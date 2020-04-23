class AchievementsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :edit, :update, :destroy]
  before_action :owners_only, only: [:edit, :update, :destroy]

  def index
    @achievements = Achievement.global_access.order(created_at: :desc)    
  end

  def new
    @achievement = current_user.achievements.build
  end

  def create
    @achievement = current_user.achievements.build(achievement_params)
    if @achievement.save
      UserMailer.achievement_created(current_user.email, @achievement.id).deliver_now
      redirect_to achievement_path(@achievement), notice: "Achievement has been created."
      # tweet = TwitterService.new.tweet(@achievement.title)
      # redirect_to achievement_path(@achievement), notice: "Achievement has been created. We tweeted for you #{tweet.url}"
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