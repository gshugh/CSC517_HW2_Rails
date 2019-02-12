FactoryBot.define do

  factory :booking do

    user
    tour

    trait :one_seat do
      num_seats {1}
    end
    trait :zero_seats do
      num_seats {0}
    end
    trait :negative_seats do
      num_seats {-1}
    end

  end

end