class SolutionsConstraintsController < ApplicationController

	# Description: Creates New record for either Method or vairable constraints
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
				method_cons.each do |cons|
					parameters = MethodParameter.new
					parameters.parameter = method_cons[:name]
					parameters.params_type = method_cons[:type]
					# constarint.parameters << parameters
					parameters.save
				end
				render json: true
				constarint.save
			else
				render json: false
			end
		end
	end

	# Description: init New record
	# Parameters: none
	# Returns: none
	# Author: Ahmed Mohamed Magdi
	def new
		constrain = MethodConstraint.new
		parameters = MethodParameter.new
	end
end
