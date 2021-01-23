FactoryBot.define do
    factory :company, class: Company do
        name { Faker::Name.name }
        legalForm {'OOO'}
        id {rand(1..1000)}
    end
  end