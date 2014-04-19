class Debugger < ActiveRecord::Base
	
	#Validations

	#Relations
	
	#Scoops
	
	#Methods
	def start(file_path , input)
		to_be_compiled = file_path
		if file_path =~ "/.*\.java/"
			file_path = file_path[0..-6]
		else
			to_be_compiled = file_path + ".java"
		end
		if !system("javac -g " + to_be_compiled)
			exit
		end
		file_path_with_args = file_path + " " + input
		if !system("java " + file_path_with_args)
			exit
		end
		hash = {}
		begin
			$input, $output, $error, $wait_thr = Open3.popen3("jdb",file_path_with_args)
			wti $output
			$input.puts "stop in #{file_path}.main"
			wti $output
			$input.puts "run"
			num = get_line $output
			$input.puts "locals"
			locals = get_locals($input, $output)
			hash[num] = locals
			debug($input, $output, hash)
		rescue
			return false
		end
		return hash
	end

	def wti(outputstr)
		buffer = ""
		until buffer.tr("\r\n","") =~ /.+>/ or buffer =~ /.+\[\d\]/ do
			begin
				temp = outputstr.read_nonblock 2048
				buffer += temp
			rescue
			end
		end
	  	return buffer
	end

	def wtd(output)
		buffer = ""
		until buffer =~ /.+\[\d\]/ do
			begin
				temp = output.read_nonblock 2048
				buffer += temp
			rescue
			end
		end
		return buffer
	end	

	def debug(inputstr , outputstr, hash)
		while !inputstr.closed? do
			begin
				inputstr.puts "step"
				num = get_line $output
				inputstr.puts "locals"
				locals = locals = get_locals($input, $output)
				hash[num] = locals
			rescue
				inputstr.close
			end
		end
	end

	def get_line(outputstr)
		out_stream = wtd outputstr
		list_of_lines = out_stream.split(/\n+/)
		last_line = list_of_lines[-2]
		/\d+/=~ last_line
		regex_capture = $&
		return regex_capture.to_i
	end

	def get_locals(in_stream, out_stream)
		out_stream = wtd outputstr
		arguments_vars = out_stream.split("Local variables:")
		arguments_before = arguments_vars[0]
		arguments_remove = arguments_before.split("Method arguments:")
		arguments_after_string = arguments_remove[1]
		arguments_list = dump_vars(arguments_after_string.split(/\n+/),
			in_stream, out_stream, "=")
		vars_before = arguments_vars[1]
		vars_remove = vars_before.split(/\n+/)
		vars_after = vars_remove[0..-2]
		vars_list = dump_vars(vars_after, in_stream, out_stream ,"=")
		return {:method => arguments_list , :vars => vars_list}
	end

	def dump_vars(arguments_vars_list, in_stream, out_stream, seperator)
		res = {}
		arguments_vars_list.each do |argument_var|
			argument_var = argument_var.strip
			var_value = argument_var.split(/#{seperator}{1}/)
			var = var_value[0]
			value = var_value[1]
			value =~ /instance of .*"/
			if value == 0
				res[var] = dump(var, in_stream, out_stream)
			else
				res[var] = value
			end
		end
		return res
	end

	def dump(var, in_stream, out_stream)
		in_stream.puts "dump " + var
		out_from_stream = wtd(out_stream).strip
		list_before = out_from_stream.split(/\n+/)
		list_after = list_before[1..-2]
		return dump_vars(list_after, in_stream, out_stream, ":")
	end

end
