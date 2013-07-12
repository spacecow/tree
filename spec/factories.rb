FactoryGirl.define do
  factory :user do
  end

  factory :article do
    name 'Factory name'
    factory :character do
      type 'Character'
      after(:build) do |article|
        article.projects << build(:project)
      end
    end
    factory :event do
      type 'Event'
      after(:build) do |article|
        article.projects << build(:project)
      end
    end
    factory :place do
      type 'Place'
      after(:build) do |article|
        article.projects << build(:project)
      end
    end
  end

  factory :history do
    content 'Factory content'
    association :historable, factory: :character
  end

  factory :relation do
    factory :enemy do
      type 'Enemy'
    end
    factory :friend do
      type 'Friend'
    end
    factory :participant do
      type 'Participant'
    end
  end

  factory :project do
    title 'Factory name'
  end
end
