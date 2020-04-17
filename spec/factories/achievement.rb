FactoryBot.define do
  factory :achievement do
    title       { "Title" }
    description { "Description" }
    featured    { false }
    cover_image { "test.png" }

    factory :global_achievement do 
      privacy { :global_access }
    end

    factory :admin_achievement do 
      privacy { :admin_access }
    end

    factory :guest_achievement do 
      privacy { :guest_access }
    end
  end
end