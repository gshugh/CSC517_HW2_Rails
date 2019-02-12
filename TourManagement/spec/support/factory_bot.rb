# Installing factory_girl:

# 0. Check spec/support dir is auto-required in spec/rails_helper.rb.
#
# 1. Add factory_girl_rails to Gemfile:
#
# group :development, :test do
#  gem 'factory_girl_rails', '~> 4.5'
# end

# 2. Create a file like this one you're reading in spec/support/factory_girl.rb:
RSpec.configure do |config|
  config.include FactoryBot::Syntax::Methods

  # config.before(:suite) do
  #   begin
  #     DatabaseCleaner.start
  #     # Test factories in spec/factories are working.
  #     FactoryGirl.lint
  #   ensure
  #     DatabaseCleaner.clean
  #   end
  # end

end
