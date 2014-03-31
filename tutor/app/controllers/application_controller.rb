class ApplicationController < ActionController::Base
  	# Prevent CSRF attacks by raising an exception.
  	# For APIs, you may want to use :null_session instead.
  	before_action :authenticate!
  	protect_from_forgery with: :exception
	before_action :update_sanitized_params, if: :devise_controller?

	private
		# Allows certain fields to passed through a form
		# Parameters: None
		# Returns: None
		def update_sanitized_params
			if "#{resource_name}" == "lecturer"
		  		devise_parameter_sanitizer.for(:sign_up) {|u| u.permit(:name, :email, :password, :password_confirmation, :degree, :dob, :profile_image, :gender, :department)}
			elsif "#{resource_name}" == "student"
				devise_parameter_sanitizer.for(:sign_up) {|u| u.permit(:name, :email, :password, :password_confirmation, :gender, :dob, :profile_image, :faculty, :major, :semester, :advising, :probation)}
			elsif "#{resource_name}" == "teaching_assistant"
				devise_parameter_sanitizer.for(:sign_up) {|u| u.permit(:name, :email, :password, :password_confirmation, :dob, :profile_image, :gender, :graduated_from, :graduated_year, :department)}
			end
		end

		# Checks for user authentication and if not authenticated, will be redirected to root
		# Parameters: None
		# Returns: None
		def authenticate!
			if signed_in? or params[:controller].include?"devise"
				return true
			else
				flash[:notice] = "You're not logged in!"
				redirect_to :root
			end

		end
end