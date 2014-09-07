require 'active_record'

class Comment < ActiveRecord::Base
  def post
    Post.select_by({id: self.post_id})
  end
end

