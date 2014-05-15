class NotesController < ApplicationController
	def create
		note = Note.new(note_params)
		if lecturer_signed_in?
			note.owner_id = current_lecturer.id
			note.owner_type = "lecturer"
		elsif teaching_assistant_signed_in?
			note.owner_id = current_teaching_assistant.id
			note_type = "teaching assistant"
		end	
		if note.save
			flash.keep[:notice] = "Note Added"
		else
			flash.keep[:notice] = "Note cannot be added"
		end
		redirect_to :back
	end
	
	# [Add Problem - 4.4]
	# Passes the input of the form as paramaters for create action to use it
	# Parameters:
	#	title: problem's title
	#	description: problem's description
	#	track_id: problem's track id
	# Returns:
	#	Params to create action & update action
	# Author: Abdullrahman Elhusseny
	private
		def note_params
			params.require(:Note).permit(:content, :solution_id, :line)
		end
end
