class Task < ActiveRecord::Base
  attr_accessible :user_id, :title, :description, :points, :daily, :sunday, :monday, :tuesday, :wednesday, :thursday, :friday, :saturday, :period, :how_often, :as_needed, :assigned, :family_id
  belongs_to :user
  has_many :completions
  validates_presence_of :title

  def self.family_chores(user)
    Task.where(family_id: user.family.id, assigned: false)
  end

  def self.parent_chores(parents)
    temp = Array.new
    date = Date.parse(Time.zone.today.to_s).strftime("%A").downcase

    parents.each do |user|
      Task.where(daily: true, user_id: user.id).each do |task|
        temp << task
      end
      Task.where(user_id: user.id, date.intern => true).each do |task|
        temp << task
      end
    end
    return temp
  end

  def self.daily_chores(user)
    temp = Array.new
    date = Date.parse(Time.zone.today.to_s).strftime("%A").downcase

    Task.where(daily: true, user_id: user.id).each do |task|
      temp << task
    end
    Task.where(user_id: user.id, date.intern => true).each do |task|
      temp << task
    end
    return temp
  end

  def self.as_needed_chores(user)
    Task.where(as_needed: true, user_id: user.id)
  end
end