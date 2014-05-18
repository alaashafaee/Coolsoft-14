module CoursesHelper

	def crop (string, length)
		s = string 
		i = length
		if s.length > i
			while s[i] != ' '
				i -= 1
			end
		else
			return s
		end
		return s.slice(0, i) + '...' 
	end
end
