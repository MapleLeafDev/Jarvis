class Event < ActiveRecord::Base
  attr_accessible :name, :start_time, :description, :user_id
  belongs_to :user
  validates_presence_of :name
end
