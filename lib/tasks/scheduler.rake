task :update_stats => :environment do
  puts "UPDATING SOCIAL MEDIA STATS"
  User.all.each do |user|
    timezone = user.timezone || "America/Los_Angeles"
    hour = (Time.now.utc + Time.now.in_time_zone(timezone).utc_offset).hour
    puts "HOUR -> #{hour}"
    if hour == 0
      if user.social_medium.any?
        user.update_social_medium_stats
        user.email_stats
      end
    end
  end
  puts "<<< DONE >>>"
end
