class UsersController < ApplicationController
	before_filter :authenticate_user!

	def home
		@user = current_user
		@contacts = @user.contacts
	end
	
	def new
		@user = User.new
	end

	def show
		@user = User.find(params[:id])
	end

	def update
		@user = User.new(params[:id])

		respond_to do
			if @user.update_attributes(params[:user])
        		redirect_to @user
      		else
				render action: "edit"
     		 end
		end
	end

	def update_image
	    @user = User.find(params[:id])
	    @user.update_attributes(params[:user])
	    redirect_to root_path
 	end

 	def search
 		@user = current_user
 		@contacts = current_user.search(params[:search])
 		render 'home'
 	end

	# def live_search
	#   query = params[:q]
	#   @user = User.find(:id => current_user)
	#   @contacts = []
	#   if query
	#   	if @user.contacts
	#   		@user.contacts.each do |x|



	#   		end
	#   	end
 #      User.only(:name,:id).where(name: /#{query}/i).all.each do |user|
 #        unless (current_user && (current_user==user))
 #          unless (user.image.url == nil)
 #            @users << {id:user.id,name:user.name, image: user.image.url}
 #          else
 #            @users << {id:user.id,name:user.name, image: nil}
 #          end
 #        end
 #      end
 #    end
 #    render :partial => 'userSearch'
	#   # @tasks = Contact.find_latest(params[:q])
	#   # render :layout => false
	# end

end
