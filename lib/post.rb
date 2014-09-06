require 'active_record'

class Post < ActiveRecord::Base
  def category
    Category.find_by({id: self.category_id})
  end
end


