class Task < ActiveRecord::Base

  belongs_to :user
  belongs_to :family
  has_many :completions

  scope :required, -> {where(required: true)}

  validates_presence_of :title, :assigned

  # CSS class for text based on status
  def status_class
    case status
    when 0
      "success"
    when 1
      "warning"
    when 2
      "danger"
    end
  end

  # status code of 0,1,2
  def status
    return 0 if completed? || !last_completion
    days_since_completed = (Date.today - last_completion.created_at.to_date).round
    if daily && days_since_completed > 1 || !daily && days_since_completed > 6
      return 2
    end
    return 1
  end

  # completed today?
  def completed?
    completions.where(completed: today).any?
  end

  # last completion object
  def last_completion
    completions.last
  end

  # user who last completed
  def completed_by
    last_completion ? last_completion.user : nil
  end

  # based on last completion and task rotation, user who is required to complete
  def up_next
    assigned_array = assigned.split(",")
    next_id = (assigned_array[assigned_array.index(completed_by.id.to_s) + (completed? ? 0 : 1)] || assigned_array[0]) rescue assigned_array.first
    User.find(next_id)
  end

  # universal date string of "today"
  def today
    user = User.find_by_id(assigned.split(",")[0])
    date = Time.now.utc + Time.now.in_time_zone(user.timezone).utc_offset
    "#{date.year}-#{date.month}-#{date.day}"
  end

  # tasks sorted by family member and who is "up_next"
  def self.sort_by_member(family_id)
    members = {}
    family = Family.find_by_id(family_id)
    family.members.each{|m| members[m.id] = []}
    family.tasks.each do |task|
      members[task.up_next.id] << task.id
    end
    return members
  end
end
