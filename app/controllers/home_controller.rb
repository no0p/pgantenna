class HomeController < ApplicationController
  
  def index
  
  	@plots = Plot.order("position asc")
  	@boxes = Box.order("position asc")
  
  end

end
