namespace :news do
  desc "Rake task to get news article"
  task :fetch => :environment do
  
    puts "#{Time.now} — Success!"
  end
end