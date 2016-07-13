task :update_stats => :environment do
  puts "Updating social medium stats..."
  User.all.each do |user|
    if user.social_medium.any?
      user.update_social_medium_stats
      user.email_stats
    end
  end
  puts "...done."
end
