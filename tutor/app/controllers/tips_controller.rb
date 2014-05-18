class TipsController < ApplicationController

 	# [View hints and tips-Story 4.22]
	# It fetches from database all the previous tips.
	# Parameters:
	#	@tips: All the previous tips that had been entered before.
	#	@tips_check:All the previous tips that had been entered before to check if it is a tip or hint.
	#	flag: decider flag to decide between add or editing.
	# Returns : none.
	# Author: Nadine Adel
	def index
		session[:model_answer_id] = params[:model_answer_id]
		@model_answer = ModelAnswer.find_by_id(params[:model_answer_id])
		@tips= Hint.get_tips @model_answer.id
	end

	# [Add tip - Story 4.10]
	# Allows Lecturer/TA to create a tip to help the student_users while solving a problem
	# Parameters: none
	# Returns:
	#	@tip: a new created tip to specific answer
	#	flag: decider flag to decide between add or editing.
	# Author: Ahmed Osam
	def new
		if params[:flag] == "1"
			session[:flag] = params[:flag]
		elsif params[:flag] == "0"
			session[:flag] = params[:flag]
		end
		session[:track_id] = params[:track_id]
		if(@tip == nil)
			session[:model_answer_id] = params[:model_answer_id]
			@model_answer = ModelAnswer.find_by_id(session[:model_answer_id])
			@tip = Hint.new
		end
	end
	
	# [Add tip - Story 4.10]
	# Allows Lecturer/TA to create a tip to help the student_users while solving a problem
	# Parameters: 
	#	message: is the content of the tip
	#	time: is a countdown timer that tip will appear after it ends.
	#	model_answer_id: is the id of the answer the tip related to.
	#	flag: decider flag to decide between add or editing.
	# Returns:
	#	@tip: a new created tip to specific answer
	# Author: Ahmed Osam
	def create
		@tip = Hint.new
		@tip.message = tip_params[:message]
		@tip.time = tip_params[:time]
		@tip.category = true
		@tip.model_answer_id = session[:model_answer_id]
		@tip.submission_counter = 0
		if lecturer_signed_in?
			@tip.owner_type = "lecturer"
			@tip.owner_id = current_lecturer.id
		elsif teaching_assistant_signed_in?
			@tip.owner_type = "teaching assistant"
			@tip.owner_id = current_teaching_assistant.id
		end
		if @tip.save
			@model_answer = ModelAnswer.find_by_id(session[:model_answer_id])
			@model_answer.hints << @tip
			if session[:flag] == "1"
				redirect_to :controller => 'tips', :action => 'index',
					:problem_id => session[:problem_id], :track_id => session[:track_id],
					:model_answer_id => session[:model_answer_id]
			elsif session[:flag] == "0"
				redirect_to :controller => 'hints', :action => 'new',
					:problem_id => session[:problem_id], :track_id => session[:track_id],
					:model_answer_id => params[:model_answer_id],:flag => session[:flag]
			end
		else
			render :action=>'new', :locals => { :model_answer_id => @tip.model_answer_id,
				:flag => session[:flag],
				:track_id => session[:track_id], :problem_id => params[:problem_id]}
		end
	end

	# [Show tip - Story 4.23]
	# Show the content of the tip that was created or edited with edit and delete buttons
	# Parameters:
	#	model_answer_id: The model answer id
	#	id: tip id that should be viewed
	# Returns: 
	#	@tip: tip that will be viewed
	# Author: Ahmed Osam
	def show
		@tip = Hint.find_by_id(params[:id])
	end


	# [Remove tip - Story 4.20]
	# Finds the tip that wanted to be removed
	# Parameters:
	#	id: id of the tip required to be removed
	# Returns:
	#	@tip: tip which will be removed
	# Author: Ahmed Osam
	def destroy
		@tip = Hint.find_by_id(params[:id])
		@tip.destroy
		redirect_to :controller => 'tips', :action => 'index',
			:problem_id => params[:problem_id], :track_id => params[:track_id],
			:model_answer_id => params[:model_answer_id]
	end

	# [Edit tip - Story 4.10]
	# Finds the tip that wanted to be edited
	# Parameters:
	#	id: id of the tip required to be edited
	# Returns: 
	#	@tip: tip which will be edited
	# Author: Ahmed Osam
	def edit
		session[:tip_id] = params[:tip_id]
		@tip = Hint.find_by_id(params[:tip_id])
	end

	# [Edit tip - Story 4.11]
	# update the tip with the new parameters
	# Parameters:
	#	id: id of the tip required to be edited
	#	time: udated time in which tip will be shown after
	#	message: updated content of tip
	# Returns:
	#	@tip: new updated tip
	# Author: Ahmed Osam
	def update
		@tip = Hint.find(session[:tip_id])
		if tip_params_edit[:message] != @tip.message ||
			tip_params_edit[:time] != @tip.time
			if @tip.message != tip_params_edit[:message]
				flash.keep[:notice] = "Content has changed"
			elsif @tip.time != tip_params_edit[:time]
				flash.keep[:notice] = "Time has changed"
			end
			begin
				if @tip.update_attributes(tip_params_edit)
					respond_to do |format|
						format.js
						format.html {redirect_to :action => "edit", :format => :js,
							:tip_id => @tip.id, :track_id => session[:track_id]}
					end
				else
					@tip = Hint.find_by_id(params[:tip_id])
					respond_to do |format|
						format.js
						format.html {redirect_to :action => "edit", :format => :js,
							:tip_id => @test_case.id, :track_id => session[:track_id]}
					end
				end
			rescue
				@tip = Hint.find_by_id(session[:tip_id])
				respond_to do |format|
					format.js
					format.html {redirect_to :action => "edit", :format => :js,
						:tip_id => @test_case.id, :track_id => session[:track_id]}
				end
			end
		end
	end

	# [Add tip - Story 4.10]
	# Take information from the form on create tip page
	# Parameters:
	#	tip: name of the form
	#	message: is the content of the tip
	#	time: is a countdown timer that tip will appear after it ends
	# Returns:
	#	none
	# Author: Ahmed Osam
	private
		def tip_params
			params.require(:tip).permit(:message, :time)
		end

	# [Edit tip - Story 4.11]
	# Take new information from a form on edit tip page
	# Parameters:
	#	tip_edit: name of the form
	#	time: udated time in which tip will be shown after
	#	message: updated content of tip
	# Returns:
	#	none
	# Author: Ahmed Osam
		def tip_params_edit
			params.require(:tip_edit).permit(:message, :time)
		end

end