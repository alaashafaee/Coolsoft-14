class Executer

	def self.execute(file, input) 
		path = '/Users/mac/Desktop/'
		compile = %x[#{'javac ' + path + file + '.java' + ' 2>&1'}]
		if compile.empty?
			@execute_res = %x[#{'java -cp ' + path + ' ' + file + ' ' + input + ' 2>&1'}]
			# puts execute_res
			if @execute_res.empty?
				true
			else
				puts compile
				false
			end
		end
	end

	def self.get_runtime_error()
		puts @execute_res
	end

	def self.get_output() 
		puts @execute_res
	end

end

Executer.execute(ARGV[0], ARGV[1])
Executer.get_runtime_error()