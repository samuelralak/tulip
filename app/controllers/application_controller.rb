class ApplicationController < ActionController::Base
	# Prevent CSRF attacks by raising an exception.
	# For APIs, you may want to use :null_session instead.
	protect_from_forgery with: :exception

	before_filter :authenticate_user!
	rescue_from CanCan::AccessDenied, with: :redirect_to_previous

	private
		def redirect_to_previous
			session[:return_to] ||= request.referer
			redirect_to session.delete(:return_to)
		end
end
