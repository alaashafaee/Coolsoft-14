module Searchable
	extend ActiveSupport::Concern

	# [Simple Search - Story 1.22]
	# search for users
	# Parameters: keyword
	# Returns: A hash with search results according to the keyword
	# Author: Ahmed Elassuty

	#class Methods
	module ClassMethods
		def simple_search(keyword)
			self.where("name LIKE ? or email LIKE ?", "%#{keyword}%", "%#{keyword}%") if keyword.present?
		end
	end

end