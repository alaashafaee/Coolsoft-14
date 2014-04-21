class ApplicationController < ActionController::Base

	# Prevent CSRF attacks by raising an exception.
	# For APIs, you may want to use :null_session instead.
	before_action :authenticate!
	protect_from_forgery with: :exception
	before_action :update_sanitized_params, if: :devise_controller?

	# [User Authentication Advanced - Story 5.9, 5.10, 5.11, 5.14, 5.15]
	# Permits some fields to be passed through sign up forms to update the lecturer,
	# 	student, and teaching_assistant models
	# Parameters: None
	# Returns: None
	# Author: Khaled Helmy
	private
	def update_sanitized_params
		if "#{resource_name}" == "lecturer"
			devise_parameter_sanitizer.for(:sign_up) {
				|u| u.permit(:name, :email, :password, :password_confirmation, :gender, :dob, :degree, 
					:university, :department, :profile_image, :profile_image_cache)
			}
		elsif "#{resource_name}" == "student"
			devise_parameter_sanitizer.for(:sign_up) {
				|u| u.permit(:name, :email, :password, :password_confirmation, :gender, :dob, :university, 
					:faculty, :major, :semester, :advising, :probation, :profile_image, :profile_image_cache)
			}
		elsif "#{resource_name}" == "teaching_assistant"
			devise_parameter_sanitizer.for(:sign_up) {
				|u| u.permit(:name, :email, :password, :password_confirmation, :gender, :dob,
					:graduated_from, :graduated_year, :degree, :university, :department, 
					:profile_image, :profile_image_cache)
			}
		end
	end

	# [User Authentication Advanced - Story 5.9, 5.10, 5.11, 5.14, 5.15]
	# Checks if a user is signed-in in order to be used in authentication over different pages
	# 	where they are redirected to homepage if they aren't authenticated
	# Parameters: None
	# Returns: None
	# Author: Khaled Helmy
	def authenticate!
		unless signed_in? or params[:controller].include?"devise"
			flash[:notice] = "You're not logged in!"
			redirect_to :root
		end
	end

end
