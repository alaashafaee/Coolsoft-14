class GradesController < ApplicationController
	def view_grades
		@assignment = Assignment.find_by_id(params[:assignment_id])
		@problems = @assignment.problems
		@students = @assignment.course.students
		@grade = 0
		@grades = Hash.new
		@counter = 1
		@students.each do |student|
			@problems.each do |problem|
				grade = Grade.where(problem_id: problem.id, student_id: student.id).first
				if grade
					@grades[@counter] = grade.grade
				else 
					@grades[@counter] = 0
				end
				@counter += 1
			end
		end
	end
end

