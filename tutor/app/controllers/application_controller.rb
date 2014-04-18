class ApplicationController < ActionController::Base

  	# Prevent CSRF attacks by raising an exception.
  	# For APIs, you may want to use :null_session instead.
  	before_action :authenticate!
  	protect_from_forgery with: :exception
	before_action :update_sanitized_params, if: :devise_controller?

	#UPDATE ALL FIELDS
	private
		def update_sanitized_params
			if "#{resource_name}" == "lecturer"
		  		devise_parameter_sanitizer.for(:sign_up) {
		  			|u| u.permit(:name, :email, :password, :password_confirmation, :gender, :dob, :degree, 
		  				:department, :profile_image, :profile_image_cache)
		  		}
		  	elsif "#{resource_name}" == "student"
				devise_parameter_sanitizer.for(:sign_up) {
					|u| u.permit(:name, :email, :password, :password_confirmation, :gender, :dob, :faculty, 
						:major, :semester, :advising, :probation, :profile_image, :profile_image_cache)
				}
			elsif "#{resource_name}" == "teaching_assistant"
				devise_parameter_sanitizer.for(:sign_up) {
					|u| u.permit(:name, :email, :password, :password_confirmation, :gender, :dob,
						:graduated_from, :graduated_year, :department, :profile_image, 
						:profile_image_cache)
				}
			end
		end

		def authenticate!
			if signed_in? or params[:controller].include?"devise"
				return true
			else
				flash[:notice] = "You're not logged in!"
				redirect_to :root
			end
		end

end
