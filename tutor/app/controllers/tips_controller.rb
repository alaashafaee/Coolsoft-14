class TipsController < ApplicationController

	def new
		@tips= Hint.all
		
	end

end