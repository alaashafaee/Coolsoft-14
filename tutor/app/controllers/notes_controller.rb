class NotesController < ApplicationController

	# [Mark Assignment - 4.29]
	# creates a new record to Note Table
	# Parameters:
	#	content: note's content through note_params
	#	solution_id: the id of the solution that the note belongs to
	#	line: integer represents the order of the line that the note belongs to
	# Returns: none
	# Author: Abdullrahman Elhusseny
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
			flash.keep[:notice] = "Note added! Hold your cursor over line of code to see the note"
		else
			flash.keep[:notice] = "Note wasn't added"
		end
		redirect_to :back
	end

	# [Mark Assignment - 4.29]
	# updates a record to Note Table
	# Parameters:
	#	content: note's content through note_params
	#	solution_id: the id of the solution that the note belongs to
	#	line: integer represents the order of the line that the note belongs to
	# Returns: none
	# Author: Abdullrahman Elhusseny
	def update
		@note = Note.find_by_id(params[:id])
		if @note.update_attributes(note_params)
			flash.keep[:notice] = "Note Updated"
		else
			flash.keep[:notice] = "Note wasn't updated"
		end
		redirect_to :back
	end

	# [Mark Assignment - 4.29]
	# Removes a record to Note Table
	# Parameters:
	#	id: the id of the note to be deleted through params
	# Returns: none
	# Author: Abdullrahman Elhusseny
	def destroy
		if Note.find_by_id(params[:id]).destroy
			flash[:notice] = "Note Deleted"
			redirect_to :back
		end
	end

	# [Mark Assignment - Story 4.29]
	# passes the input of the form as paramaters for create & update action
	# Parameters:
	#	content: note's content through note_params
	#	solution_id: the id of the solution that the note belongs to
	#	line: integer represents the order of the line that the note belongs to
	# Returns:
	#	params to create action & update action
	# Author: Abdullrahman Elhusseny
	private
		def note_params
			params.require(:Note).permit(:content, :solution_id, :line)
		end
end
