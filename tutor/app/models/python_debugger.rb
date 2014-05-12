require "open3"
class PythonDebugger

	#Methods

	def get_variables

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
