FactoryGirl.define do
  sequence :nickname do |n|
    "john_#{n}"
  end
  sequence :email do |n|
    "john_#{n}@test.com"
  end
end
