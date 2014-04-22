class SolutionsConstraintsController < ApplicationController
	def create
		method_cons = params[:parameter_constraint]
		@var_cons = params[:variable_constraint]

		method = params[:method_name]
		method_returned = params[:method_return]

		unless method == ""
			@constarint = MethodConstraint.new
			@constarint.method_name = method
			@constarint.method_return = @method_returned
			
			if method_cons.present?
				method_cons.each do |cons|
					@parameters = MethodParameter.new
					@parameters.parameter = method_cons[:name]
					@parameters.params_type = method_cons[:type]
					# @constrain.parameters << @parameters
					@parameters.save
				end
				render json: true
				@constarint.save
			else
				render json: false
			end
			
		end
	 	
	end

	def new
		@constrain = MethodConstraint.new
	end
end
