class SessionController < ApplicationController

	def new
	end
	
	def destroy
		session[:valid] = false
		redirect_to login_path
	end

	def create
		redirect_to status_path
	end
	
end
