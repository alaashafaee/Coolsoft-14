require "open3"
class PythonDebugger

	#Methods

	def get_variables
		local_variables = []
		class_variables = get_class_variables
		input "dir()"
		output_buffer = buffer_until_complete
		output_buffer.each_line do |line|
			new_line = line[1..-1]
			list_of_variables = new_line.split(", ");
			local_variables << list_of_variables
		end
		return local_variables
	end

	def get_stack_trace
		stack_trace = []
		input "w"
		output_buffer = buffer_until_complete
		output_buffer.each_line do |line|
			if line.match("->")
				stack_trace << line
			end
		end
		return stack_trace
	end

end
