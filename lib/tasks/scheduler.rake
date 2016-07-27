task :update_stats => :environment do
  puts "Updating social medium stats..."
  User.all.each do |user|
    timezone = user.timezone || "America/Los_Angeles"
    if (Time.now.utc + Time.now.in_time_zone(timezone).utc_offset).hour == 0
      if user.social_medium.any?
        user.update_social_medium_stats
        user.email_stats
      end
    end
  end
  puts "...done."
end
