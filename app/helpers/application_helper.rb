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
    if user.moderator
      mark = '<i class="bi bi-check" style="color: #00e700;"></i>'
      mark.html_safe
    else
      ''
    end
  end

end
