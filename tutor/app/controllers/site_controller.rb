class SiteController < ApplicationController
	def index
		Student.first.get_a_system_suggested_problem
	end
end
