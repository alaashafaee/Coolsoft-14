class TeachingAssistantsController < ApplicationController
	def index
	end
	def show
		@teaching_assistant = TeachingAssistant.find(params[:id])
	end
end