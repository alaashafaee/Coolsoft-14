class CompilersController < ApplicationController
	
	def test
		compiler = Compiler.last
		@res = compiler.compile_test
	end	
end
