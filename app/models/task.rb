class Task < ActiveRecord::Base

  belongs_to :user
  belongs_to :family
  has_many :completions

  scope :required, -> {where(required: true)}

  validates_presence_of :title, :assigned

  def completed?
    completions.where(completed: today).any?
  end

  def last_completion
    completions.last
  end

  def completed_by
    last_completion ? last_completion.user : nil
  end

  def up_next
    assigned_array = assigned.split(",")
    (assigned_array[assigned_array.index(completed_by.id.to_s) + (completed? ? 0 : 1)] || assigned_array[0]) rescue assigned_array.first
  end

  def today
    user = User.find_by_id(assigned.split(",")[0])
    date = Time.now.utc + Time.now.in_time_zone(user.timezone).utc_offset
    "#{date.year}-#{date.month}-#{date.day}"
  end

  def self.sort_by_member(family_id)
    members = {}
    family = Family.find_by_id(family_id)
    family.members.each{|m| members[m.id] = []}
    family.tasks.each do |task|
      members[task.up_next.to_i] << task.id
    end
    return members
  end
end
