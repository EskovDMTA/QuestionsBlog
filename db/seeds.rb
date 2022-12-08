50.times do 
    title = Faker::Music::Hiphop.artist
    body = Faker::Movie.quote
    Question.create title: title, body: body
end
