require 'ffaker'

40.times do |n|
  user_name = "username#{n+1}"
  name = FFaker::Name.name
  email = FFaker::Internet.email
  password = 'foobar'
  User.create!(
      user_name: user_name,
      name: name,
      email: email,
      password: password,
      password_confirmation: password,
      activated: true,
      activated_at: Time.zone.now
  )
end
