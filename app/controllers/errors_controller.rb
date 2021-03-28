class ErrorsController < ApplicationController
  before_action :require_username

  def not_found
    custom_meta_tags('Error 404', "Sorry, the page you searched doesn't exist!",
                     %w[error 404 missing learn oshiwambo])

    render status: 404
  end

  def internal_server_error
    custom_meta_tags('Error 500', "Internal server error! Contact us if this error persists.",
                     %w[error 500 server learn oshiwambo])

    render status: 500
  end
end
