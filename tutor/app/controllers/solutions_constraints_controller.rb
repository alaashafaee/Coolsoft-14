class SolutionsConstraintsController < ApplicationController
	def index
		@parameters = MethodParameter.all
		@variables = VariableConstraint.all 
		#@methods = MethodConstraints.all 
	end

	def create
		param_type = params[:p_type]
		param_name = params[:p_name]
		var_type = params[:v_type]
		var_name = params[:v_type]
		method_return = params[:method_return]
		method_name = params[:method_name]

		myhash = {}
		param_name.each_with_index do |k,i|
			myhash[k] = param_type[i]
		end

		myhash.each do |key, value|
			puts(key + value)
		end


	end

	def new
		@constrain = MethodConstraint.new
		@params = MethodParameter.new
		@variables = VariableConstraint.new
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

	def update
		@parameters = MethodParameter.find_by_id(params[:id])
		@variables = VariableConstraint.find_by_id(params[:id])
		if @parameters.update_attributes(constraint_params) && @variables.update_attributes(constraint_params)
			redirect_to :action => 'show'
		else
			redirect_to :action => 'index'
		end
	end

	def delete
		@parameters = MethodParameter.find_by_id(params[:id])
		@variables = VariableConstraint.find_by_id(params[:id])	
	end

	def destroy
		@parameters = MethodParameter.find_by_id(params[:id]).destroy
		@variables = VariableConstraint.find_by_id(params[:id]).destroy
		flash[:success_deletion] = "Constraints deleted."
	end

end
