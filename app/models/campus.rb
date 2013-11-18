class Campus < ActiveRecord::Base
	attr_accessible :name   

	scope :sort_by_name, order("name")

end
