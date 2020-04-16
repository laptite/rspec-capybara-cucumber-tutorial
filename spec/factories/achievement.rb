FactoryBot.define do
  factory :achievement do
    title       { "Title" }
    description { "Description" }
    privacy { Achievement.privacies[:admin_access] }
    featured    { false }
    cover_image { "test.png" }

    factory :global_achievement do 
      privacy { Achievement.privacies[:global_access]}
    end
  end
end