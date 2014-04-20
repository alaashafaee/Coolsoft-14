class SolutionsConstraintsController < ApplicationController
	def show
		@parameters = MethodParameter.find_by_id(params[:id])
		@variables = VariableConstraint.find_by_id(params[:id])
		#if @constraints.nil?
		#	render "constraints_not_Found"
		#end
	end

	def edit
		if lecturer_signed_in? || teaching_assistant_signed_in?
			@parameters = MethodParameter.find_by_id(params[:id])
			@variables = VariableConstraint.find_by_id(params[:id])	
		end
	end

	#def delete
	#	constraint.find(params[id]).destroy
	#end

end
