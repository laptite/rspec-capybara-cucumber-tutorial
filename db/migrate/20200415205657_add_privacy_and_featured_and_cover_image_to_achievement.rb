class AddPrivacyAndFeaturedAndCoverImageToAchievement < ActiveRecord::Migration[6.0]
  def change
    add_column :achievements, :privacy, :integer
    add_column :achievements, :featured, :boolean
    add_column :achievements, :cover_image, :string
  end
end
