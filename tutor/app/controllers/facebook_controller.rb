class FacebookController < ApplicationController
  def index
  	me = FbGraph::Student.me(ACCESS_TOKEN)
	me.feed!(
  		:message => 'Updating via FbGraph',
	)
  end
  def show
  	render ('index')
  end
end