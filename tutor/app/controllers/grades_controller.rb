class GradesController < ApplicationController
	def create
		grade = Grade.new(grade_params)
		if lecturer_signed_in?
			grade.editor_id = current_lecturer.id
			grade.editor_type = "lecturer"
		elsif teaching_assistant_signed_in?
			grade.editor_id = current_teaching_assistant.id
			grade.editor_type = "teaching assistant"
		end
		if grade_params(:grade).blank?
			flash.keep[:notice] = "Please enter a grade"
			redirect_to :back
		else
			if grade.save?
				flash.keep[:notice] = "Grade is saved"
				redirect_to :back
			end
			else
				flash.keep[:notice] = "Grade is not saved"
				redirect_to :back
		end
	end


	private
		def grade_params
			params.require(:Grade).permit(:grade, :problem_id, :student_id)
		end
end
