task :update_stats => :environment do
  puts "Updating social medium stats..."
  User.all.each do |user|
    time_zone = 'PDT' # user.timezone
    if (Time.now.utc + Time.zone_offset(time_zone)).hour == 0
      if user.social_medium.any?
        user.update_social_medium_stats
        user.email_stats
      end
    end
  end
  puts "...done."
end
