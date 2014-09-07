module EventsHelper

  def event_label(event, family)
    if event.event_type == "meal"
      "info"
    else
      case event.user_id 
      when family[0].id
        "default"
      when family[1].id
        "primary"
      when family[2].id
        "success"
      when family[3].id
        "warning" 
      when family[4].id
        "danger"
      else 
        "info"
      end
    end
  end

  def member_label(member, family)
    case member.id
    when @family[0].id
      "default"
    when @family[1].id
      "primary"
    when @family[2].id
      "success"
    when @family[3].id
      "warning"
    when @family[4].id
      "danger"
    else 
      "info"
    end
  end
end