FactoryGirl.define do
  factory :user, aliases: [:follower, :followed] do
    nickname { generate(:nickname) } 
    email { generate(:email) } 
    firstname 'John'
    lastname 'Doe'
    bio 'Blah blah blah'
  end
end
    