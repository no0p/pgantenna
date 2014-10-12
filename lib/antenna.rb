#
# 
#
class Antenna

  include Antenna::Commands

  SUCCESS_RESPONSE = "OK+"

  def initialize
    @port = 24831
  end

  #
  # Create http server, await connection.  Pass connection to handler method.
  #
  def start!
    @server = TCPServer.new(@port)
    puts "Server Started"
    loop do
    	puts "Listening..."
      client = @server.accept
      record_connection(client)
      puts "Connection Accepted"
      serve_connection(client)
    end
  end
  
  #
  #
  #
  def serve_connection(client)
    begin
		  loop do
		  	puts "Wait..."
    	  # Read complete message from socket
		  	#  Note that this loop is kind of weird.  Maybe can have command group terminator eventually.
		  	message, commands = "", []
		  	while (message[-2..-1] != "\r\n")
		      message += client.readline
		    end
		    # puts message #
		    commands = message.split("\r\n")    
		    
	      # Do appropriate response        
        commands.each do |c| 
          # puts c #
          current_command = c 
          response = handle_command(c)
          client.puts response
          # puts response #
        end
		  end
    rescue EOFError => e
    	puts "EOF"
    	puts e.to_s
    	puts e.backtrace.join("\n")
   	rescue StandardError => e
   	  if e.to_s.match /Broken pipe/
   	    puts "Client Disconnect."
   	    # Client disconnect -- naturally occuring
   	  else
		 	  puts e.to_s
		   	puts e.backtrace.join("\n")
		  end
		ensure
			@conn.update_attributes(:disconnected_at => Time.now)
			client.close
   	end
  end
  
  #
  #
  #
  def handle_command(command)
    # Process Data
    command, data = parse_command(command)
    puts command
    
    if command.match(/HNDSHK/)
      # Establishing connection?
      response = handshake(data) 
    else
      # Process Command if we have identified cluster
      response = case command
      	when /HARTBT/ then 
      		heartbeat(data)
      	when /PRMGUC/ then 
      		restart_gucs(data)
        when /TMPGUC/ then 
          transient_gucs(data)
        when /COLNFO/ then 
        	column_info(data)
        when /COLSTA/ then
          column_stats(data)
        when /RELNFO/ then
          relation_info(data)
        when /INDNFO/ then
          index_info(data)
       	when /DBLIST/ then 
       		dblist(data)
        when /TBSTAT/ then
          table_stats(data)
        when /IDSTAT/ then
          index_stats(data)
        when /FNSTAT/ then
          function_stats(data)
        when /TISTAT/ then
          table_io_stats(data)
        when /IISTAT/ then
          index_io_stats(data)
        when /RPSTAT/ then
          replication_stats(data)
        when /BGSTAT/ then
          bg_writer_stats(data)
        when /DBSTAT/ then
          db_stats(data)
       	when /STAACT/ then
       		stat_activity(data)
        when /SYSNFO/ then
        	sys_info(data)
        when /FSINFO/ then
          fs_info(data)
        when /STSTMT/ then
          stat_statements(data)
      	else
      		unknown_command(command, data)
     	end
    end
   	
   	return response
  end
  
  #
  # Extract the command type from the message and the data string
	#
	def parse_command(message)
		command = message[0..5] # fixed length command
		data = message[7..-1].strip # was -3 skip semicolon, remove whitespace at end.  might remove semicolong someday
		return command, data
	end

	#
	# Create a record for this connection.
	#
	def record_connection(client)
		client_info = client.addr(:hostname)
		ConnectionInfo.where("disconnected_at is null").each {|c| c.delete} # TODO, consider better ways to cleanup freak situations.
		@conn = ConnectionInfo.create(:ip => client_info[3], :hostname => client_info[2], :connected_at => Time.now)
	end

end
