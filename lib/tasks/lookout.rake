namespace :lookout do
  desc 'run all alerts and notify if triggered'
  task :check => :environment do
    Lookout.check!
  end
end
