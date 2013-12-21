class Completion < ActiveRecord::Base
  attr_accessible :user_id, :task_id, :completed

  belongs_to :user
  belongs_to :task
end
