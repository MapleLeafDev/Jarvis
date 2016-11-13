class Task < ActiveRecord::Base

  belongs_to :user
  belongs_to :family
  has_many :completions

  scope :required, -> {where(required: true)}

  validates_presence_of :title

  def completed?
    completions.where(completed: Date.today.to_s).any?
  end

  def required?
    required
  end
end
