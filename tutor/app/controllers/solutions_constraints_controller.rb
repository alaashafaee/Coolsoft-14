class SolutionsConstraintsController < ApplicationController

	# Description: Creates New record for either Method or variable constraints
	# Parameters:
	#	method_cons: Hash containting the Method parameters
	#	var_cons: Hash containting the Variables Constraints
	#	method: value of the method name.
	#	method_returned: value of the method return type
	# Returns: none
	# Author: Ahmed Mohamed Magdi
	def create
		method_cons = params[:parameter_constraint]
		var_cons = params[:variable_constraint]
		method = params[:method_name]
		method_returned = params[:method_return]

		unless method == ""
			constarint = MethodConstraint.new
			constarint.method_name = method
			constarint.method_return = method_returned
			if method_cons.present?
				method_cons.each do |index,value|
					parameters = MethodParameter.new
					parameters.parameter = value[:name]
					parameters.params_type = value[:type]
					parameters.save
					constarint.method_parameter << parameters
				end
			end
			constarint.save
		end
		if var_cons.present?
			var_cons.each do |index,value|
				variable = VariableConstraint.new
				variable.variable_name = value[:name]
				variable.variable_type = value[:type]
				variable.save
			end
		end

		render json: true
	end

	# Description: init New record
	# Parameters: none
	# Returns: none
	# Author: Ahmed Mohamed Magdi
	def new
		constrain = MethodConstraint.new
	end
end
