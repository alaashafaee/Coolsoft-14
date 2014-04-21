class Executer

	def self.execute(file_name, input)
		# java_path = 'students_solutions/Java/'
		classes_path = 'students_solutions/Class'
		# compile = %x[#{'javac -g -d ' + classes_path + ' ' + java_path + file + '.java' + ' 2>&1'}]
		# if compile.empty?
		problem_id = 3
		validity = check_input_validity(input, problem_id)
		if validity[:status]
			@execute_res = %x[#{'java -cp ' + classes_path + ' ' + file_name + ' ' + input + ' 2>&1'}]
			if @execute_res.include?("Exception")
				return false
			else
				return true
			end
		else
			@execute_res = validity[:msg]
			return false
		end
		# end
	end

	def self.check_input_validity(input, problem_id)
		# variables_number = Problem.find_by_id(problem_id).variable_constraints.count
		variables_number = 2
		if input.include?("\n")
			return {status: false, msg: "Input can not have line breaks \"don't use enter\""}
		end
		if input.split(" ").count != variables_number
			msg = "Enter only " + variables_number.to_s + " numbers"
			return {status: false, msg: msg}
		end
		return {status: true, msg:""}
	end

	def self.remove_class_name(file_name, error, sub_name)
		return error.gsub(file_name, sub_name)
	end

	def self.get_runtime_error(file_name, sub_name)
		@execute_res = remove_class_name(file_name, @execute_res, sub_name)
		if @execute_res.include?("/ by zero")
			message = "Division by Zero results in infinity, "\
						"which computers can not understand. Be careful !"
			return msg = {error: @execute_res, explaination: message}
		else
			message = "To be set Runtime Error!"
			return msg = {error: @execute_res, explaination: message}
		end
	end

	def self.get_output()
		return @execute_res
	end

end