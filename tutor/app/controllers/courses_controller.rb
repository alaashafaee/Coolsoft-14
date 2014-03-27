class CoursesController < ApplicationController
	def show

			@courses = Lecturer.find_by_name('Lecturer2').courses
		end
	end

