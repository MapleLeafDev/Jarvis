class Family < ActiveRecord::Base

  has_many :users
  has_many :events, dependent: :destroy
  has_many :tasks, dependent: :destroy
  has_many :activities, dependent: :destroy
  has_many :meals, dependent: :destroy

  validates_presence_of :name, :url

  def portal_url
    "http://#{Rails.env.development? ? request.host_with_port : 'www.ml-family.com'}/my_family/" + url
  end

  def parents
    users.where(parent: true)
  end

  def children
    users.where(parent: false)
  end

  def email
    name
  end

  def todays_tasks
     day = User::DAYS_OF_WEEK[Time.now.wday]
     tasks.where("daily = 't' OR #{day} = 't'")
  end

  def other_tasks
    tasks - todays_tasks
  end
end
