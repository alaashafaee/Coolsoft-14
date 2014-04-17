class HintsController < ApplicationController
  def new
  		@hints = Hint.all
		
		@hint = Hint.new
  end

  def create
  end

  def edit
  end

  def destroy
  end
end
