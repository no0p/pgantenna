#
# This controller provides endpoints for adding, deleting, and editing box stat 
#   and plot records.  These are the actual monitoring information displayed on 
#   the status page.
#
# Box Stats are queries where the first row/column entry in the result set
#   are displayed as a single number. 
#
# Plots are queries that are passed to the plot() function from provided by the
#   plotpg library.
#
# Alerts are queries such that if the first field in the first row is true, then
#   an alert action will be triggered, sending emails to all configured alert emails.
#
class EditorController < ApplicationController

	def index_box
		@boxes = Box.all
	end
	
	def index_plot
		@plots = Plot.all
	end
	
	def index_alert
		@alerts = Alert.all
	end

	def new_plot
		@include_ace = true
		@plot = Plot.new
	end
	
	def new_box
		@include_ace = true
		@box = Box.new
	end
	
	def new_alert
		@include_ace = true
		@alert = Alert.new
	end
	
	def edit_plot
		@include_ace = true
		@plot = Plot.find params[:id]
	end
	
	def edit_box
		@include_ace = true
		@box = Box.find params[:id]
	end
	
	def edit_alert
		@include_ace = true
		@alert = Alert.find params[:id]
	end
	
	def update_plot
		p = Plot.find params[:id]
		if p.update_attributes(:title => params[:title],
												:query => params[:query],
												:height => params[:height],
												:width => params[:width])
			flash[:notice] = "Plot updated"
			redirect_to index_plot_path
		else
			flash[:notice] = p.errors.to_a.join(", ").to_s
			redirect_to edit_plot_path(p.id)
		end
	end
	
	def update_box
		b = Box.find params[:id]
		if b.update_attributes(:label => params[:label],
													 :query => params[:query])
			flash[:notice] = "Box updated"
			redirect_to index_box_path
		else
			flash[:notice] = b.errors.to_a.join(", ").to_s
			redirect_to edit_box_path(b.id)
		end

	end
	
	def update_alert
		a = Alert.find params[:id]
		if a.update_attributes(:label => params[:label],
												:query => params[:query],
												:message => params[:message])
			flash[:notice] = "Alert updated"
			redirect_to index_alert_path
		else
			flash[:notice] = a.errors.to_a.join(", ").to_s
			redirect_to edit_alert_path(a.id)
		end
	end

	def create_plot	
		p = Plot.create(:title => params[:title],
									:query => params[:query])
		if p.id.present?
			flash[:notice] = "Plot created"
			redirect_to index_plot_path
		else
			flash[:notice] = p.errors.to_a.join(", ").to_s
			redirect_to new_plot_path
		end
	end
	
	def create_box
		b = Box.create(:label => params[:label],
									:query => params[:query])
		if b.id.present?
			flash[:notice] = "Box created"
			redirect_to index_box_path
		else
			flash[:notice] = b.errors.to_a.join(", ").to_s
			redirect_to new_box_path
		end
	end
	
	def create_alert
		a = Alert.create(:label => params[:label],
									:query => params[:query],
									:message => params[:message])
		if a.id.present?
			flash[:notice] = "Alert created"
			redirect_to index_alert_path
		else
			flash[:notice] = a.errors.to_a.join(", ").to_s
			redirect_to new_alert_path
		end
	end
	
	def delete_plot
		@plot = Plot.find params[:id]
		@plot.delete
		redirect_to index_plot_path
	end
	
	def delete_box
		@box = Box.find params[:id]
		@box.delete
		redirect_to index_box_path
	end
	
	def delete_alert
		@box = Alert.find params[:id]
		@box.delete
		redirect_to index_alert_path
	end

	def reset_boxes
		Reset.boxes!
		redirect_to index_box_path
	end
	
	def reset_plots
		Reset.plots!
		redirect_to index_plot_path
	end
	
	def reset_alerts
		Reset.alerts!
		redirect_to index_alert_path
	end

end
