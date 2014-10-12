
module Lookout

  def self.check!
    Alert.all.each do |a|
    	puts a.label
    	if a.trigger?
	    	Notification.create(:alert_id => a.id)
	      notify(a.label, a.message)
	    end
    end
  end

  def self.notify(label, message)
    @settings = Setting.first

    emails = AlertEmail.all.map {|i| i.email}
    if emails.length > 0 && Rails.env != "test" && @settings.ses_access_key.present? && @settings.ses_secret_key.present? && @settings.ses_from_email.present?

	    ses = AWS::SES::Base.new(:access_key_id     => @settings.ses_access_key, 
	                             :secret_access_key => @settings.ses_secret_key)
	    ses.send_email(:to => emails,
	                   :source => @settings.ses_from_email,
	                   :subject => label,
	                   :text_body => message)
		  
		  
		  return "Email Sent"
    end
  end
end

