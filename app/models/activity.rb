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
    nil,
    "instagram",
    "facebook-square",
    "tumblr-square",
    "twitter-square",
    "google-plus-square",
    "pinterest-square"
  ]

  def css_class
    CSS_NAME[type_id]
  end

  def date
    (self.posted_at  + Time.now.in_time_zone(self.user.timezone).utc_offset).strftime('%F')
  end
end
