class Item < ActiveRecord::Base
	validates_presence_of :name

	def completed?
		!!completed_at
	end
end
