FactoryBot.define do
  factory :achievement do
    title       { "Title" }
    description { "Description" }
    featured    { false }
    cover_image { fixture_file_upload(Rails.root.join('spec', 'fixtures', 'cover_image.jpg'), 'image/jpeg') }

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