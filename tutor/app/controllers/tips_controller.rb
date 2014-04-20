class TipsController < ApplicationController
	def new
		if(@tips == nil)
			@tips = Hint.new
		end
	end

	def show
	end

	def create
		@tips = Hint.new
		@tips.message = tip_params[:message]
		@tips.time = tip_params[:time]
		@tips.category = true
		if @tips.save
	  		current_lecturer.hints << @tips
	  		@tip = @tips
	  		render :action => 'show'
		else
	  		render :action=>'new'
		end
	end


	def index
	end

	def destroy
	end

	def edit
	end

	def update
	end

  	private
	def tip_params 
		params.require(:tip).permit(:message, :time)
	end

end