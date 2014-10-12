class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  
  before_filter :authenticate, :connection_status
  
  #
  # Require authentication if security token is set.
  #
  def authenticate
  	@settings = Setting.first
  	return true if @settings.access_token.blank?

  	session[:valid] = true if @settings.access_token == BCrypt::Engine.hash_secret(params[:access_token], @settings.access_token_digest)
  	return true if session[:valid]
  	
  	# Redirect to login unless logging in
  	@suppress_navbar = true
  	redirect_to login_path unless request.path == login_path
  end
  
  #
  # Display client connection status in navbar...
  #
  def connection_status
  	@current_connection = ConnectionInfo.where("disconnected_at is null").first
  end
  
end
