module ApplicationHelper

  def form_group_tag(errors, &block)
    if errors.any?
      content_tag :div, capture(&block), class: 'form-group has-error'
    else
      content_tag :div, capture(&block), class: 'form-group'
    end
  end

  # Mark all moderators across site
  def is_moderator(user)
    if user&.moderator
      mark = '<span data-bs-toggle="tooltip" data-bs-placement="top"
                    title="Indicates a moderator. Moderators verify if translations are correct or not.">
                  <i class="bi bi-check remove-webkit m-0 p-0" style="color: #00e700;" type="button"></i>
              </span>'
      mark.html_safe
    else
      ''
    end
  end

  def get_time(created_at)
    user_zone = "Africa/Abidjan"
    user_now = Time.find_zone(user_zone).now
    created_at_local = created_at.in_time_zone(user_zone)

    difference = user_now - created_at_local
    if 60 > difference
      difference.round.to_s + "s"
    elsif 3600 > difference
      (difference / 1.minute).round.to_s + "m"
    elsif 86400 > difference
      (difference / 1.hour).round.to_s + "h"
    else
      created_at_local.strftime("%b %d, %Y")
    end
  end

end
