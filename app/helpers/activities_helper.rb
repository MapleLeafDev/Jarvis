module ActivitiesHelper
  def activity_post_link(activity)
    case activity.type_id
    when 1
      instagram_post_user_social_medium_index_path(activity.user, feed_id: activity.user.instagram.id, media_id: activity.media_id)
    else
      ""
    end
  end
end
