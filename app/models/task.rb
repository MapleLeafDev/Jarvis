class Task < ActiveRecord::Base
  attr_accessible :user_id, :title, :description, :points, :daily, :weekly, :monthly, :sunday, :monday, :tuesday, :wednesday, :thursday, :friday, :saturday, :period, :how_often, :custom_start
  belongs_to :user
  has_many :completions
end
