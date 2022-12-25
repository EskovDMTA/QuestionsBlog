# 50.times do 
#     title = Faker::Music::Hiphop.artist
#     body = Faker::Movie.quote
#     Question.create title: title, body: body
# end

# User.find_each do |u| 
#     u.send(:set_gravatar_hash)
#     u.save
# end


30.times do 
    title = Faker::Music::Hiphop.artist

    Tag.create title: title
end

