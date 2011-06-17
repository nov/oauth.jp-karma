class TopController < ApplicationController
  before_filter :require_anonymous_access

  def index
    flash[:notice] = {
      title: 'flash.title.welcome'.t(identifier: 'nov'),
      text:  'flash.description.welcome'.t,
      image: PicoMoney.first.thumbnail
    }
  end
end
