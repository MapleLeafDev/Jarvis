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

  def parent?
    parent
  end

  def child?
    !parent
  end

  def todays_tasks
    []
  end
end