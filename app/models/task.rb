class Task < ActiveRecord::Base
  
  belongs_to :user
  belongs_to :family
  has_many :completions

  validates_presence_of :title

  def completed?
    completions.where(completed: Date.today.to_s).any?
  end
end