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

  erb(:index, { locals: { categories: Category.all(), posts: Post.all() } })
end

get("/categroies/:id/posts") do #shows all posts chron backwards in 1 category
  # Post.limit(10).order(asc)
  empty_cat = params["category.id"]
  posts = Post.where(:category_id => params["category.id"])

  erb(:posts_by_category, { locals: { categories: Category.all(), posts: posts, empty_cat: empty_cat } })
end

get("/posts/:id") do #shows one post
  post = Post.find_by({id: params["id"]})

  comments = Comment.where(:post_id => params["id"])

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

put("/posts/thumbsdown/:id") do #This does not work!!!!!
  binding.pry

  increment = params["downvotes"] + 1

  post_hash = { 
    author: params["author"],
    source: params["source"],
    posted_by: params["posted_by"],
    quote: params["quote"],
    expires_on: params["expires_on"],
    downvotes: increment,
    upvotes: params["upvotes"],
    category_id: params["category_id"]  
  }

  post = Post.find_by({id: params["id"]})
  post.update(post_hash)

  comments = Comment.where(:post_id => params["id"])

  erb(:post_show, { locals: { post: post, comments: comments, categories: Category.all() } })
end







