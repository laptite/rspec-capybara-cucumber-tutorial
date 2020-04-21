class UserMailer < ApplicationMailer

  def achievement_created(email, achievement_id)
    @achievement_id = achievement_id
    mail to: email,
    subject: 'Your new achievement has been successfully created'
  end
end
