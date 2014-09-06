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
  erb(:index, { locals: { categories: Category.all(), posts: Post.all() } })
end

get("/posts/:id") do #shows one post
  erb(:post_show)
end

get("/categroies/:id/posts") do #shows posts from one category chron backwards
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


get("/categroies/posts/new") do #shows form to make new Post

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

  erb(:post_show, { locals: { post: post } }) #after someone posts a new post they see a page of just their post alone.
end




# ___________________________


get("/characters") do
  erb(:"characters/index", { locals: { characters: Character.all(), } })
end

get("/characters/new") do
  erb(:"characters/new", { locals: { houses: House.all(), } })
end

post("/characters") do
  character_hash = { 
    name: params["name"], 
    image_url: params["url"], 
    house_id: params["house_id"]
  }

  Character.create(character_hash)

  erb(:"characters/index", { locals: { characters: Character.all() } })
end

get("/characters/:id") do
  character = Character.find_by({id: params[:id]})
  erb(:"characters/show", { locals: { character: character } })
end

get("/characters/:id/edit") do
  character = Character.find_by({id: params[:id]})
  erb(:"characters/edit", { locals: { character: character, houses: House.all() } })
end

put("/characters/:id") do
  character_hash = { 
    name: params["name"], 
    image_url: params["url"], 
    house_id: params["house_id"]
  }

  character = Character.find_by({id: params[:id]})
  character.update(character_hash)

  erb(:"characters/show", { locals: { character: character } })
end

delete("/characters/:id") do
  character = Character.find_by({id: params[:id]})

  binding.pry
  
  character.destroy

  redirect "/characters"
end

get("/houses") do
  erb(:"houses/index", { locals: { houses: House.all() } })
end

get("/houses/:id") do
  house = House.find_by({id: params[:id]})
  erb(:"houses/show", { locals: { house: house } })
end