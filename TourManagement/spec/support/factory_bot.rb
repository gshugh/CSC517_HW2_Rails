################################################################################
# Include factory_bot methods,
#
# per https://medium.com/@lukepierotti/setting-up-rspec-and-factory-bot-3bb2153fb909

require 'factory_bot'

RSpec.configure do |config|
  config.include FactoryBot::Syntax::Methods
end