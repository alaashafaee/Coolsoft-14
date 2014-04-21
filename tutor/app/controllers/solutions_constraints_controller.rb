class SolutionsConstraintsController < ApplicationController
	def index
		@parameters = MethodParameter.all
		@variables = VariableConstraint.all 
		@methods = MethodConstraint.all 
	end

	def show
		@parameters = MethodParameter.find_by_id(params[:id])
		@variables = VariableConstraint.find_by_id(params[:id])
		@methods = MethodConstraint.find_by_id(params[:id])
		if @parameters.nil?
			redirect_to :action => 'index'
		end
	end

	def edit
		if lecturer_signed_in? || teaching_assistant_signed_in?
			@parameters = MethodParameter.find_by_id(params[:id])
			@variables = VariableConstraint.find_by_id(params[:id])
			@methods = MethodConstraint.find_by_id(params[:id])	
		end
	end

	def update
		if @parameters = MethodParameter.find_by_id(params[:id]) &&
			@variables = VariableConstraint.find_by_id(params[:id]) &&
			@methods = MethodConstraint.find_by_id(params[:id])
			@parameters.update_attributes(constraint_params) 
			@variables.update_attributes(constraint_params) 
			@methods.update_attributes(constraint_params)
			flash[:notice] = "Constraints updated"
			redirect_to :action => 'show'
		else
			redirect_to :action => 'index'
		end
	end

	def destroy
		if parameters = MethodParameter.find_by_id(params[:id]).destroy &&
			variables = VariableConstraint.find_by_id(params[:id]).destroy &&
			methods = MethodConstraint.find_by_id(params[:id]).destroy	
			flash[:notice] = "Constraints deleted."
			redirect_to :action => 'edit'
		else
			flash[:error] = "Constraints is not deleted."
			redirect_to :action => 'show'
		end
	end

	private
	def constraint_params
		params.require(:parameter).permit(:parameters, :variables, :methods)
	end
end