class ProfileController < ApplicationController

	def edit
	end

	def save 
		if student_signed_in? 
			@student = Student.find(current_student.id)
			@student.update_attributes(params.permit(:name , :age, :email, :faculty , :major, :semester, :gender , :advising, :probation ))
			@student.save
			 
		elsif lecturer_signed_in?
			@lecturer = Lecturer.find(current_lecturer.id)
			@lecturer.update_attributes(params.permit(:name ,:age, :gender, :email, :department , :degree ))
			@lecturer.save
			
		elsif teaching_assistant_signed_in?
			@teaching_assistant = TeachingAssistant.find(current_teaching_assistant)
			@teaching_assistant.update_attributes(params.permit(:name, :age, :gender, :email , :department, :graduated_from))
			@teaching_assistant.save	
				
		end
			redirect_to(:root)
	end


end
