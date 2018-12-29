Faker::Config.locale = :ja

10.times do
  Task.create!(
      task: Faker::Lorem.sentence
  )
end