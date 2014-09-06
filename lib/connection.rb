require 'active_record'

ActiveRecord::Base.establish_connection({
  :adapter => "postgresql",
  :host => "localhost",
  :username => "JillOrtenberg",
  :database => "wisdom"
})

ActiveRecord::Base.logger = Logger.new(STDOUT)