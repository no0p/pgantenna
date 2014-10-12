namespace :antenna do

  desc 'launch an antenna server'
  task :start => :environment do

    a = Antenna.new
    a.start!
  end
end
