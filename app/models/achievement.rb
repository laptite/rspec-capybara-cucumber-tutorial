class Achievement < ApplicationRecord
  belongs_to :user
  validates :title, presence: true
  enum privacy: [:global_access, :admin_access, :friends_access]

  has_one_attached :cover_image

  def self.privacies_collection
    privacies.map { |k,v| [k.split('_').first.capitalize, k] }
  end
end
