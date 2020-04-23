FactoryBot.define do
  factory :encouragement do
    user
    achievement
    message { "My String" }
  end
end
