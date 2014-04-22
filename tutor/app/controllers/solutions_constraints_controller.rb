class SolutionsConstraintsController < ApplicationController
	def index
		@parameters = MethodParameter.all
		@variables = VariableConstraint.all 
		#@methods = MethodConstraints.all 
	end

	def create
		method_cons = params[:parameter_constraint]
		@var_cons = params[:variable_constraint]

		method = params[:method_name]
		method_returned = params[:method_return]

		unless method == ""
			@constarint = MethodConstraint.new
			@constarint.method_name = method
			@constarint.method_return = @method_returned
			
			unless method_cons.blank?
				method_cons.each do |cons|
					@parameters = MethodParameter.new
					@parameters.parameter = method_cons[:cons][:name]
					@parameters.params_type = method_cons[:cons][:type]
					# @constrain.parameters << @parameters
					@parameters.save
				end
			end
			@constarint.save
		end
	end

	def new
		@constrain = MethodConstraint.new
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
