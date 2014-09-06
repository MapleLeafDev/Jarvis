class Family < ActiveRecord::Base

  has_many :users
  has_many :events, dependent: :destroy
  has_many :tasks, dependent: :destroy
  
  validates_presence_of :name, :url

  def email
    name
  end

  def todays_tasks
     day = User::DAYS_OF_WEEK[Time.now.wday]
     tasks.where("daily = 't' OR #{day} = 't'")
  end
end
