class CoursesController < ApplicationController
	#[Course Sign-Up - Story 2.6]
	#Allows students to sign-up/register for new courses by choosing
	#	the desired course attributes in the following order:
	#	University > Semester > Course > Instructor > Sign-Up > Confirmation
	#Parameter:
	#	params[]: A hash of the request URL attributes
	#Returns:
	#	@status: The next status (0:Failure:Not a student, 1:University, 2:Semester, 3:Course,
	#		4:Instructor, 5:Sign-Up, 6:Confirmation, 7:Failure:Already signed up)
	#	@courses: A list of the courses
	#	@course: The chosen course
	#	@lecturer: The chosen lecturer
	#Author: Ahmed Moataz
	def sign_up
		@status = params[:status]	
		if student_signed_in?
			case params[:status]
			when nil
				@courses = Course.select(:university).distinct
				@status = "1"
			when "2"
				@courses = Course.where("university= " + "\""+ params[:university] + "\"").select(:semester).distinct
			when "3"
				@courses = Course.where("semester= " + params[:semester])	
			when "4"
				@course = Course.find_by_code(params[:code])
			when "5"
				@course = Course.find_by_code(params[:code])
				@lecturer = Lecturer.find(params[:lecturer])
			when "6"
				@course = Course.find_by_code(params[:code])
				@lecturer = Lecturer.find(params[:lecturer])
				#Insertion in the DB
				student = Student.find(current_student.id)
				if student.courses.find_by_id(@course.id) == nil
					student.courses << @course
				else
					@status = "7"
				end		
			end
		else
			@status = "0"	
		end	
	end
end
