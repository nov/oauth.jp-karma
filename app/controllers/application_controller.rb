class ApplicationController < ActionController::Base
  include Authentication
  include Notification

  protect_from_forgery
  after_filter :flash_to_cookie
end
