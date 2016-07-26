task :update_stats => :environment do
  puts "Updating social medium stats..."
  User.all.each do |user|
    time_zone = user.time_zone || "America/Los_Angeles"
    if (Time.now.utc + Time.now.in_time_zone(time_zone).utc_offset).hour == 0
      if user.social_medium.any?
        user.update_social_medium_stats
        user.email_stats
      end
    end
  end
  puts "...done."
end
