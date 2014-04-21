class TeachingAssistantsController < ApplicationController
	def show
		@teaching_assistant = TeachingAssistant.find(params[:id])
	end
	def index
	end
end