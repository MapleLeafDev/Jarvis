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

    def events_previous_link
    ->(param, date_range) { link_to "<span class='glyphicon glyphicon-chevron-left'></span>".html_safe, {param => date_range.first - 1.day} }
  end

  def events_next_link
    ->(param, date_range) { link_to "<span class='glyphicon glyphicon-chevron-right'></span>".html_safe, {param => date_range.last + 1.day} }
  end

  def events_table
    "table table-striped table-bordered"
  end

end