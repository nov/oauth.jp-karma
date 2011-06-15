class TransactionsController < ApplicationController
  before_filter :require_authentication

  rescue_from OpenTransact::HttpException, with: :opentransact_error

  def create
    current_account.transactions.create!(params[:transaction])
    flash[:notice] = {
      title: 'Succeeded'.t,
      text: 'Just sent {amount} of Karma {to}'.t(:amount => amount, :to => to)
    }
    redirect_to dashboard_url
  end

  private

  def opentransact_error(e)
    flash[:error] = e.message
    redirect_to dashboard_url
  end
end
