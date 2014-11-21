class User < ActiveRecord::Base
  has_secure_password

  belongs_to :family
  has_many :tasks, dependent: :destroy
  has_many :completions, dependent: :destroy
  has_many :purchases, dependent: :destroy
  has_many :events, dependent: :destroy
  has_many :social_medium, dependent: :destroy, class_name: 'SocialMedia'
  has_many :activities, dependent: :destroy

  validates_presence_of :name
  validates_uniqueness_of :email, allow_blank: true

  scope :default_order, -> {order('parent')}

  DAYS_OF_WEEK = ["sunday","monday","tuesday","wednesday","thursday","friday","saturday"]

  def parent?
    parent
  end

  def child?
    !parent
  end

  def todays_tasks
     day = DAYS_OF_WEEK[Time.now.wday]
     tasks.where("daily = 't' OR #{day} = 't'")
  end

  def task_progress
    total = todays_tasks.count
    completed = todays_tasks.select{|x| x.completed?}.count

    [completed, total]
  end

  def weekly_task_progress
    completed = 0
    total = (tasks.where(daily: true).count * 7) + tasks.where(daily: false).count

    tasks.each do |task|
      completed += task.completions.where("completed > ?", Date.today.beginning_of_week.to_s).count
    end

    [completed, total]
  end

  def instagram?
    social_medium.where(feed_type: 1).any?
  end

  def instagram
    social_medium.where(feed_type: 1).first
  end

  def facebook?
    social_medium.where(feed_type: 2).any?
  end

  def facebook
    social_medium.where(feed_type: 2).first
  end

  def tumblr?
    social_medium.where(feed_type: 3).any?
  end

  def tumblr
    social_medium.where(feed_type: 3).first
  end
end