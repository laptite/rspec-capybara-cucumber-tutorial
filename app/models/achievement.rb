class Achievement < ApplicationRecord
  validates :title, presence: true
  enum privacy: [:public_access, :private_access, :friends_access]

  def self.privacies_collection
    privacies.map { |k,v| [k.split('_').first.capitalize, v] }
  end
end
