class Completion < ActiveRecord::Base

  belongs_to :user
  belongs_to :task

  after_create :apply_allowance, :create_activity

  private

  def create_activity
    if user.family_id
      Activity.create(
        type_id: 1,
        user_id: user.id,
        family_id: user.family_id,
        message: task.title
      )
    end
  end

  def apply_allowance
    user.apply_allowance
  end
end
