class User < ActiveRecord::Base
  has_secure_password

  belongs_to :family
  has_many :tasks, dependent: :destroy
  has_many :completions, dependent: :destroy
  has_many :purchases, dependent: :destroy
  has_many :events, dependent: :destroy
  has_many :social_medium, dependent: :destroy, class_name: 'SocialMedia'

  validates_presence_of :name
  validates_uniqueness_of :email, allow_blank: true

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
    total = todays_tasks.count.to_f
    completed = todays_tasks.select{|x| x.completed?}.count.to_f

    ((completed / total) * 100)
  end
end