RSpec.configure do |config|
  FactoryBot.reload
  config.include FactoryBot::Syntax::Methods
end