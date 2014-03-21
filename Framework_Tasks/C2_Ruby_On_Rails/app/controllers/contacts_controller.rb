class ContactsController < ApplicationController
	
	def new
		@contact = Contact.new
	end

	def create
		@contact = Contact.new(params[:contact])
		@contact.user_contact = current_user
		if @contact.save
			current_user.contacts << @contact
			redirect_to root_path
		else
			render 'new'
		end
	end

	def update
    @user = Contact.find(params[:id])

    respond_to do |format|
      if @user.update_attributes(params[:user])
        format.html { redirect_to @user }
      else
        format.html { render action: "edit" }
      end
    end
  end

	def edit
		@contact = Contact.find(params[:id])
	end

	def show
		@contact = Contact.find(params[:id])
	end

	def destroy
		@contact = Contact.find(params[:id])
		current_user.contacts.destroy(@contact._id)
		if @contact.destroy
			rander root_path
		else
			render root_path
		end
	end

end
