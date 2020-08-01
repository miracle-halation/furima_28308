class ApplicationController < ActionController::Base
	before_action :configure_permitted_parameters, if: :devise_controller?

	private

	def configure_permitted_parameters
		devise_parameter_sanitizer.permit(:sign_up, keys: [:nickname, :family_name, :family_name_reading, :first_name, :first_name_reading, :birthday])
	end

end
