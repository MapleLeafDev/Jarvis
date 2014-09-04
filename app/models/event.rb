class Event < ActiveRecord::Base
  belongs_to :user
  validates_presence_of :name, :start_time
end