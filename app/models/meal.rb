class Meal < ActiveRecord::Base
  belongs_to :family

  def add_activity
    if family_id
      Activity.create(
        type_id: 2,
        family_id: family_id,
        message: "#{name},#{menu_day}"
      )
    end
  end
end
