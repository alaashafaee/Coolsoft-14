class ContributorsController < ApplicationController

	skip_before_filter :authenticate!
	
	def index
		@contributors = Contributor.order("name")
	end

end
