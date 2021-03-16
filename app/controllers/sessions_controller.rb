class SessionsController < Devise::SessionsController

  def new
    custom_meta_tags('Log in to your account', 'Sign in to Learn Oshiwambo and contribute', %w[sign_in login log_in signin])

    self.resource = resource_class.new(sign_in_params)
    clean_up_passwords(resource)
    yield resource if block_given?
    respond_with(resource, serialize_options(resource))
  end

end