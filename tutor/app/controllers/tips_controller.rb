class TipsController < ApplicationController
	def new
		if(@tips == nil)
			@tips = Hint.new
		end
	end

	def show
		@tips = Hint.find_by_id(params[:id])
		@tip = Hint.find_by_id(params[:id])
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
		@tip = Hint.find_by_id(params[:id])
	end

	def update
		@tip = Hint.find(params[:id])
		@tip.category = true
		@tip.time = tip_params_edit[:time]
		@tip.message = tip_params_edit[:message]
		if @tip.save
			render :action => 'show'
		else
			render :action=>'edit'
		end
	end

	private
	def tip_params 
		params.require(:tip).permit(:message, :time)
	end
	private
		def tip_params_edit 
		params.require(:tip_edit).permit(:message, :time)
		end

end