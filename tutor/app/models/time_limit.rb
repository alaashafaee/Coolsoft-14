require 'timeout'
require 'open3'
class TimeLimit

	# [Terminate - Story X.9]
	# Run the system call given and terminate it or Terminate the given block
	# 	after the time given is reached while running
	# Parameters:
	# 	time: The time for the program not to exceed
	# 	args: The system call to be executed
	# Returns:
	#	In case there is an args passes it will return the output and error streams lines
	# 	else none
	# Author: Mussab ElDash
	def self.start time, args = ""
		unless args.empty?
			stdin, stdout, stderr, wait_thr = Open3.popen3 args
			pid = wait_thr.pid
			begin
				status = Timeout::timeout(time) {
					Process.wait(pid)
				}
			rescue => e
			end
			stdin.close
			begin
				Process.kill("TERM", pid)
			rescue => e
			end
			result_out = stdout.read
			result_err = stderr.read
			return result_out, result_err
		else
			begin
				status = Timeout::timeout(time) {
					yield
				}
			rescue => e
			end
		end
	end
end