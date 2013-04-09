class Blog < ActiveRecord::Base
  attr_accessible :body, :title, :writer
end
