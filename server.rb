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

  erb(:index, { locals: { categories: Category.all(), posts: Post.all() } })
end

get("/posts/:id") do #shows one post
  post = Post.find_by({id: params["id"]})

  comments = Comment.where(:post_id => params["id"])

  erb(:post_show, { locals: { post: post, comments: comments, categories: Category.all() } })
end

get("/categories/:id/posts") do #shows posts from one category chron backwards
  erb(:posts_by_category, { locals: { categories: Category.all(), posts: Post.all() } })
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

  erb(:post_show, { locals: { post: post, categories: Category.all(), posts: Post.all() } }) #after someone posts a new post they see a page of just their post alone.
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

post("/posts/thumbdown/") do

  post = Post.find_by({id: params["id"]})

 #does it need to be a puts edit to do this????
  post.downvotes += 1

  erb(:post_show, { locals: { post: post, categories: Category.all(), posts: Post.all(), comments: Comment.all() } })
end

# put("/characters/:id") do
#   character_hash = { 
#     name: params["name"], 
#     image_url: params["url"], 
#     house_id: params["house_id"]
#   }

#   character = Character.find_by({id: params[:id]})
#   character.update(character_hash)

#   erb(:"characters/show", { locals: { character: character } })
# end







