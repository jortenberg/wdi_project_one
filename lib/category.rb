require 'active_record'

class Category < ActiveRecord::Base
  def posts
    Post.where({category_id: self.id})
  end
end


