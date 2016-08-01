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

end
