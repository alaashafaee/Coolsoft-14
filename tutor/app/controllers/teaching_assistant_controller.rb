class Teaching_assistantController < ApplicationController
	def show
		@teaching_assistant = teaching_assistant.find(params[:id])
	end
	def new
	end
end