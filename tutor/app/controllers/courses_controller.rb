class CoursesController < ApplicationController
	def sign_up
		@status = params[:status]	
		case params[:status]
		#shouls start from "1" -> Uni	
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
			#Insert in the DB
			#@student = Student.find_by_id(...)
			#@student.courses << @course	
		 end 			
	end
end
