################################################################################
# This is the factory for the booking model. Define different number of
# seats to ensure that the number of seats is a non-negative integer.
#
# This spec assumes that the following gems are installed.
#
# rspec-rails: https://github.com/rspec/rspec-rails
# Shoulda-matchers: https://github.com/thoughtbot/shoulda-matchers
# shoulda-callback-matchers: https://github.com/beatrichartz/shoulda-callback-matchers
# factory_bot: https://github.com/thoughtbot/factory_bot

FactoryBot.define do

  factory :waitlist do
    user
    tour
    num_seats {4}

    # 1257 use different trait names between factories
    trait :for_one_seat do
      num_seats {1}
    end
    trait :for_zero_seats do
      num_seats {0}
    end
    trait :for_negative_seats do
      num_seats {-1}
    end
    trait :for_float_seats do
      num_seats {3.5}
    end

  end

end