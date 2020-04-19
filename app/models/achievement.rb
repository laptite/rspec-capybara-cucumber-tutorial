class Achievement < ApplicationRecord
  belongs_to :user
  validates :title, presence: true
  enum privacy: [:global_access, :admin_access, :friends_access]

  def self.privacies_collection
    privacies.map { |k,v| [k.split('_').first.capitalize, k] }
  end

  def self.get_public_achievements; end
end
