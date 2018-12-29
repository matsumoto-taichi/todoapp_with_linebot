Faker::Config.locale = :ja

10.times do
  Task.create!(
      task: Faker::Lorem.sentence #=> loremな文章
  )
end