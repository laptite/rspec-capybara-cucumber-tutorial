Feature: Achievement Page

Scenario: Guest user sees public achievement
  Given I am a guest user
  And there is a public achievement
  When I navigate to the achievement's page
  Then I must see the achievement's content