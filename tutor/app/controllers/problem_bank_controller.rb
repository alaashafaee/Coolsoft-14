class ProblemBankController < ApplicationController
	def show
		@problems = Problem.all
	end
end
