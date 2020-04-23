class EncouragementForm
  include Capybara::DSL

  def initialize
  end

  def leave_encouragement(attrs = {})
    fill_in('encouragement_message', with: attrs.fetch(:message, 'good job'))
    self
  end

  def submit
    click_on("Encourage")
  end
end