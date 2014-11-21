class Event < ActiveRecord::Base
  extend SimpleCalendar
  has_calendar attribute: :start_time
  
  belongs_to :user
  validates_presence_of :name, :start_time
end