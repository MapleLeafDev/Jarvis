class SocialMediumStat < ActiveRecord::Base
  belongs_to :user

  def format_data
    data = {}
    attributes.each do |k,v|
      next if ["id","user_id","created_at","updated_at"].include?(k)
      next unless v
      values = posts = followers = following = []
      days = v.split(',')
      day = ((Time.now.utc + Time.zone_offset('PST')).to_date - (days.count - 1).days).cwday
      days.each do |d|
        parts = d.split(':')
        if values.any?
          posts += [[I18n.t("days")[day], (parts[0].to_i - values[0])]]
          followers += [[I18n.t("days")[day], (parts[1].to_i - values[1])]]
          following += [[I18n.t("days")[day], (parts[2].to_i - values[2])]]
          day = day == 7 ? 1 : (day + 1)
        end
        values = [parts[0].to_i, parts[1].to_i, parts[2].to_i]
      end
      data[k] = [{name: I18n.t('posts'), data: posts}, {name: I18n.t('following'), data: following}, {name: I18n.t('followers'), data: followers}]
    end
    return data
  end

  def update_data
    stats = self
    data_hash = {}
    self.user.social_medium.each do |sm|
      case sm.feed_type
      when 1
        data = stats.instagram.split(',') rescue []
        data = data[1..7] if data.count == 8
        info = sm.instagram_info['counts']
        new_data = "#{info['media']}:#{info['followed_by']}:#{info['follows']}"
        data_hash[:instagram] = (data + [new_data]).join(',')
      when 2

      when 3

      when 4
        data = stats.twitter.split(',') rescue []
        data = data[1..7] if data.count == 8
        info = sm.twitter_info
        new_data = "#{info.tweets_count}:#{info.followers_count}:#{info.friends_count}"
        data_hash[:twitter] = (data + [new_data]).join(',')
      end
    end
    stats.update_attributes(data_hash)
  end
end
