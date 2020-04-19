class CreateAchievement
  attr_reader :achievement

  def initialize(params, user)
    @params = params
    @user = user
  end

  def create; end

  def created?; end
end