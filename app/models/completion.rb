class Completion < ActiveRecord::Base

  belongs_to :user
  belongs_to :task

  after_create :create_activity

  private

  def create_activity
    if user.family_id
      Activity.create(
        type_id: 0,
        user_id: user.id,
        family_id: user.family_id,
        message: task.title,
        posted_at: Time.now.utc
      )
    end
  end

end
