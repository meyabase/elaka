module ApplicationHelper
  # How to set up reCAPTCHA
  # https://dev.to/morinoko/adding-recaptcha-v3-to-a-rails-app-without-a-gem-46jj
  RECAPTCHA_SITE_KEY = Rails.application.credentials.dig(:recaptcha_site_key)

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

  def include_recaptcha_js
    raw %Q{
      <script src="https://www.google.com/recaptcha/api.js?render=#{RECAPTCHA_SITE_KEY}"></script>
    }
  end

  def recaptcha_execute(action)
    id = "recaptcha_token_#{SecureRandom.hex(10)}"

    raw %Q{
      <input name="recaptcha_token" type="hidden" id="#{id}"/>
      <script>
        grecaptcha.ready(function() {
          grecaptcha.execute('#{RECAPTCHA_SITE_KEY}', {action: '#{action}'}).then(function(token) {
            document.getElementById("#{id}").value = token;
          });
        });
      </script>
    }
  end

end
