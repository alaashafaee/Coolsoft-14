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

	def download_grades
		kit = PDFKit.new(html, :page_size => 'Letter')
 		pdf = kit.to_pdf
 		file = kit.to_file('/home/husseny/Downloads/GradesList/pdf')
		kit = PDFKit.new(File.new('/views/grades/view_grades'))
		PDFKit.new('<html><head><meta name="pdfkit-page_size" content="Letter"')
		PDFKit.new('<html><head><meta name="pdfkit-cookie cookie_name1" content="cookie_value1"')
		PDFKit.new('<html><head><meta name="pdfkit-cookie cookie_name2" content="cookie_value2"')
	end

end

