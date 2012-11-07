FactoryGirl.define do
  factory :user do
  end

  factory :article do
    name 'Factory name'
    factory :character do
      type 'Character'
    end
    factory :event do
      type 'Event'
    end
  end

  factory :history do
    content 'Factory content'
  end

  factory :relation do
    factory :enemy do
      type 'Enemy'
    end
    factory :friend do
      type 'Friend'
    end
  end

  factory :project do
    title 'Factory name'
  end
end
