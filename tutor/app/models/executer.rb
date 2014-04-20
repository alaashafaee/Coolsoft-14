class Executer

	def self.execute(file, input) 
		java_path = 'students_solutions/Java/'
		classes_path = 'students_solutions/Class'

		compile = %x[#{'javac -g -d ' + classes_path + ' ' + java_path + file + '.java' + ' 2>&1'}]
		if compile.empty?
			@execute_res = %x[#{'java -cp ' + classes_path + ' ' + file + ' ' + input + ' 2>&1'}]
			if @execute_res.empty?
				true
			else
				false
			end
		end
	end

	def self.get_runtime_error()
		@execute_res
	end

	def self.get_output() 
		puts @execute_res
		return @execute_res
	end

end

# Executer.execute(ARGV[0], ARGV[1])
# Executer.get_runtime_error()