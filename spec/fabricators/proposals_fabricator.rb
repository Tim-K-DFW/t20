Fabricator(:proposal) do
  producer { Faker::Name.name }
  new_firm { Faker::Company.name }
  recruiting_firm { Faker::Company.name }
  phone { Faker::Number.number(10) }
  email { Faker::Internet.email(max_length: 40) }
  current_age { (21..35).to_a.sample }
  retirement_age { (45..69).to_a.sample } 
  current_production { (2..20).to_a.sample * 100000}
  bonus { (1..1000000).to_a.sample }
  production_growth { (6..20).to_a.sample }
  current_payout { (30..55).to_a.sample }
  new_payout { (56..99).to_a.sample }
  final { true }
end