################################################################################
# Include factory_bot methods,
#
# per https://medium.com/@lukepierotti/setting-up-rspec-and-factory-bot-3bb2153fb909

RSpec.configure do |config|
  config.include FactoryBot::Syntax::Methods
end