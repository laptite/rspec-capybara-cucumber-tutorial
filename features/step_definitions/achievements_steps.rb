Given(/^I am a guest user$/) do
  # Empty step -- Describes context
end

Given(/^there is a public achievement$/) do
  @achievement = FactoryBot.create(:global_achievement, title: 'I did it')
end

When(/^I navigate to the achievement's page$/) do
  visit(achievement_path(@achievement.id))
end

Then(/^I must see the achievement's content$/) do
  expect(page).to have_content("I did it")

end
