class AdminController < ApplicationController

	def settings
		@settings = Setting.first
		@alert_emails = AlertEmail.all
	end
	
	def save_token
		@settings = Setting.first
		
		if params[:access_token].blank?
			@settings.access_token_digest = nil
			@settings.access_token = nil
			if @settings.save
				flash[:notice] = "Token no longer required to access pgantenna."
			else
				flash[:notice] = "There was a problem disabling token access."
			end
		else
			@settings.access_token_digest = BCrypt::Engine.generate_salt
		  @settings.access_token = BCrypt::Engine.hash_secret(params[:access_token], @settings.access_token_digest)
		  if @settings.save
		  	flash[:notice] = "Token updated successfullly.  You will now be required to login."
		  else
		  	flash[:notice] = "There was a problem saving the token."
		  end
		end
   	redirect_to settings_path
	end
	
	def save_settings
		Setting.first.update_attributes(:ses_secret_key => params[:ses_secret_key],
																		:ses_access_key => params[:ses_access_key],
																		:ses_from_email => params[:ses_from_email],
																		:repeat_notification_after_seconds => params[:repeat_notification_after_seconds])
		
		flash[:notice] = "Settings saved."
		redirect_to settings_path
	end
	
	def create_alert_email
		ae = AlertEmail.create(:email => params[:email])
		if ae.id.present?
			flash[:notice] = "Alert Email Created"
		else
			flash[:notice] = ae.errors.to_a.join(", ").to_s
		end
		redirect_to settings_path
	end
	
	def delete_alert_email
		ae = AlertEmail.find params[:id]
		ae.delete
		flash[:notice] = "AlertEmail deleted."
		redirect_to settings_path
	end
	
	def send_test_email
    flash[:notice] = "Attempted to send email message."
		begin
    	Lookout.notify('This is a test of pgantenna email facility', 'If you received this email, you will probably receive an alert email when an alert is triggered in pgantenna.')
  	rescue AWS::SES::ResponseError => e
	  	flash[:notice] = e.to_s
	  end
		    
    redirect_to settings_path
	end

end
