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
	
	def update
		@note = Note.find_by_id(params[:id])
		if @note.update_attributes(note_params)
			flash.keep[:notice] = "Note Updated"
		else
			flash.keep[:notice] = "Note cannot be Updated"
		end
		redirect_to :back
	end


	# [Remove Problem - Story 4.18]
	# This action takes the problem id, remove it from the database
	#	and then redirects the user to the show page of the track that had the problem
	#	with a "Problem successfully Deleted" message.
	# Parameters:
	#	params[:id]: The current problem's id
	# Returns: 
	#	flash[:notice]: A message indicating the success of the deletion
	# Author: Ahmed Atef
	def destroy
		if Note.find_by_id(params[:id]).destroy
			flash[:notice] = "Note Deleted"
			redirect_to :back
		end
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
