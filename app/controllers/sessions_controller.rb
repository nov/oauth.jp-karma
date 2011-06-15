class SessionsController < ApplicationController
  before_filter :require_anonymous_access, except: :destroy

  def show
    account = PicoMoney.authenticate!(
      params[:oauth_token],
      session[:request_token_secret],
      params[:oauth_verifier]
    )
    authenticate account
    flash[:notice] = {
      title: 'flash.title.welcome'.t(:identifier => current_account.pico_money.identifier),
      text:  'flash.description.welcome'.t,
      image: current_account.pico_money.thumbnail
    }
    redirect_to dashboard_url
  end

  def create
    request_token = PicoMoney.request_token!(session_url)
    session[:request_token_secret] = request_token.secret
    redirect_to request_token.authorize_url
  end

  def destroy
    unauthenticate!
    redirect_to root_url
  end
end
