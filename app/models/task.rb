class Task < ActiveRecord::Base

  belongs_to :user
  belongs_to :family
  has_many :completions

  scope :required, -> {where(required: true)}

  validates_presence_of :title, :assigned

  def completed?
    completions.where(completed: Date.today.to_s).any?
  end

  def last_completion
    completions.last
  end

  def completed_by
    last_completion ? last_completion.user : nil
  end

  def up_next
    last_completed_by = completed_by
    assigned_array = assigned.split(",")
    (assigned_array[assigned_array.index(last_completed_by.id.to_s) + 1] || assigned_array[0]) rescue assigned_array.first
  end

  def self.sort_by_member(family_id)
    members = {}
    family = Family.find_by_id(family_id)
    family.members.each{|m| members[m.id] = []}
    family.tasks.each do |task|
      next_assigned = task.up_next
      members[next_assigned.to_i] << task.id
    end
    return members
  end
end
