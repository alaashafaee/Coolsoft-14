class SolutionsConstraintsController < ApplicationController
	def index
		@parameters = MethodParameter.all
		@variables = VariableConstraint.all 
		#@methods = MethodConstraints.all 
	end

	def show
		@parameters = MethodParameter.find_by_id(params[:id])
		@variables = VariableConstraint.find_by_id(params[:id])
		#@methods = MethodConstraints.find_by_id(params[:id])
		if @parameters.nil?
			redirect_to :action => 'index'
		end
	end

	def edit
		if lecturer_signed_in? || teaching_assistant_signed_in?
			@parameters = MethodParameter.find_by_id(params[:id])
			@variables = VariableConstraint.find_by_id(params[:id])
			#@methods = MethodConstraints.find_by_id(params[:id])	
		end
	end

	#def delete
	#	constraint.find(params[id]).destroy
	#	flash[:success_deletion] = "Constraints deleted."
	#end

end
