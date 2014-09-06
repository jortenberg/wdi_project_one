require 'pry'
require_relative './lib/connection'
require_relative './lib/category'
require_relative './lib/post'
require_relative './lib/comment'


love = Category.create({
  name: "Love",
  description: "Love is one of the best things in Life!",
  upvotes: 3,
  downvotes: 1
})

Post.create({
  author: "Jon Krakauer",
  source: "Into the Wild",
  posted_by: "Jill Ortenberg",
  quote: "Happiness is only real when shared.",
  expires_on: 20140918,
  upvotes: 2,
  downvotes: 1,
  category_id: love.id
})

# Comment.create({
#   say: "This is so true!"
#   post_id:
# })

  
