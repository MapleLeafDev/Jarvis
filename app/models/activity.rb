class Activity < ActiveRecord::Base

  belongs_to :family
  belongs_to :user

  TYPE = [
    "Task",      # 0
    "Instagram", # 1
    "Facebook",  # 2
    "Tumblr",    # 3
    "Twitter",   # 4
    "Google",    # 5
    "Pinterest", # 6
  ]

  CSS_NAME = [
    "check",
    "instagram",
    "facebook",
    "tumblr",
    "twitter",
    "google-plus",
    "pinterest"
  ]

  def css_class
    CSS_NAME[type_id]
  end

  def full_date
    ((self.posted_at || self.created_at)  + Time.now.in_time_zone(self.user.timezone).utc_offset)
  end

  def date
    ((self.posted_at || self.created_at)  + Time.now.in_time_zone(self.user.timezone).utc_offset).strftime('%F')
  end
end
