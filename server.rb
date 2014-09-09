require 'pry'
require 'sinatra'
require 'sinatra/reloader'
require_relative './lib/connection'
require_relative './lib/category'
require_relative './lib/post'
require_relative './lib/comment'


after do
  ActiveRecord::Base.connection.close
end

get("/") do #shows all posts chron backwards
  # Post.limit(10).order(asc)
  # Post.limit(10).last
  # User.find_each(start: 2000, batch_size: 5000) do |user|
  # NewsLetter.weekly_deliver(user)
  # posts = Post.all().last(10).reverse

  # posts_10 = Post.where("id" < params["id"]).limit(10) #.order('id asc')
  # start_after_id = (most_recent_10posts.last).id

  erb(:index, { locals: { categories: Category.all(), posts: Post.all() } })
end

get("/categories/:id/posts") do #shows all posts chron backwards in 1 category

  posts = Post.where({category_id: params["category_id"]})
  category = Category.find_by({id: params["category_id"]})

  erb(:posts_by_category, { locals: { categories: Category.all(), posts: posts, category: category } })
end

get("/posts/:id") do #shows one post
  post = Post.find_by({id: params["id"]})

  comments = Comment.where(:post_id => params["id"])

  # binding.pry

  erb(:post_show, { locals: { post: post, comments: comments, categories: Category.all() } })
end

get("/categories/new") do #shows form to make new Category
  erb(:categories_new, { locals: { categories: Category.all() } })
end

post("/categories/new") do #posts new Category form
  categories_hash = {
    name: params["name"],
    description: params["description"],
  }

  Category.create(categories_hash)

  erb(:index, { locals: { categories: Category.all(), posts: Post.all() } })
end

delete("/categories/:id") do
  category = Category.find_by({id: params[:id]})
  
  category.destroy

  erb(:index, { locals: { categories: Category.all(), posts: Post.all() } })
end


get("/categories/posts/new") do #shows form to make new Post

  category = Category.find_by({id: params[:category_id]}) 

  erb(:posts_new, { locals: { category: category, categories: Category.all(), posts: Post.all() } })
end

post("/posts/new") do
  post_hash = { 
    author: params["author"],
    source: params["source"],
    posted_by: params["posted_by"],
    quote: params["quote"],
    expires_on: params["expires_on"],
    category_id: params["category_id"]  
  }

  Post.create(post_hash)

  post = Post.find_by({quote: params["quote"]})

  comments = Comment.where(:post_id => post.id)

  erb(:post_show, { locals: { post: post, comments: comments, categories: Category.all() } }) #after someone posts a new post they see a page of just their post alone.
end

post("/posts/comment") do #post comment from form on the post_show.erb page
  comment_hash = { 
    say: params["say"],
    post_id: params["post_id"]  
  }

  Comment.create(comment_hash)

  post = Post.find_by({id: params["post_id"]})

  comments = Comment.where(:post_id => params["post_id"])

  erb(:post_show, { locals: { post: post, comments: comments, categories: Category.all() } })
end

put("/posts/thumbsup/:id") do 
  post = Post.find_by({id: params["id"]})

  if post.upvotes == nil
    post.upvotes = 1
  else 
    post.upvotes += 1
  end

  post.save()

  redirect "/posts/#{post.id}"
end

put("/posts/thumbsdown/:id") do
  post = Post.find_by({id: params["id"]})

  if post.downvotes == nil
    post.downvotes = 1
  else 
    post.downvotes += 1
  end

  post.save()

  redirect "/posts/#{post.id}"
end

put("/categories/thumbsup/:id") do 
  category = Category.find_by({id: params["id"]})

  if category.upvotes == nil
    category.upvotes = 1
  else 
    category.upvotes += 1
  end

  category.save()

  redirect "/"
end

put("/categories/thumbsdown/:id") do
  category = Category.find_by({id: params["id"]})

  if category.downvotes == nil
    category.downvotes = 1
  else 
    category.downvotes += 1
  end

  category.save()

  redirect "/"
  # redirect "/categories/#{category.id}/posts"
end








