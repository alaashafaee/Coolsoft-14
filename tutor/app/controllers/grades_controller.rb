class GradesController < ApplicationController
	def view_grades
		@assignment = Assignment.find_by_id(:params[:assingment_id])
		@problems = @assignment.problems
		@students = @assignment.course.students
	end
end

