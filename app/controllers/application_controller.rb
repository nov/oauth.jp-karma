class ApplicationController < ActionController::Base
  include Authentication
  include Notification

  protect_from_forgery
  after_filter :flash_to_cookie

  rescue_from ActiveRecord::RecordInvalid do |e|
    notify_error e.record.errors.full_messages.to_sentence
  end
  rescue_from OpenTransact::HttpException do |e|
    notify_error e.message
  end

  def notify_error(message)
    redirect_to base_endpoint, flash: {error: message}
  end

  def base_endpoint
    if authenticated?
      dashboard_url
    else
      root_url
    end
  end
end
