FactoryBot.define do

    factory :employee, class: Employee do
      name { Faker::Name.name }
      secondName { Faker::Name.name }
      surname { Faker::Name.name}
      hireDate { Faker::Date.backward(days: 14)}
      id {rand(1..100)}
      position {'developer'}
      association :company
    end
  end