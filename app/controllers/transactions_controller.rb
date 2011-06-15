class TransactionsController < ApplicationController
  before_filter :require_authentication

  rescue_from OpenTransact::HttpException, with: :opentransact_error

  def create
    transaction = current_account.transactions.create!(params[:transaction])
    flash[:notice] = {
      title: 'flash.title.transaction_completed'.t,
      text: 'flash.description.transaction_completed'.t(
        :amount => transaction.amount,
        :to => transaction.to
      )
    }
    redirect_to dashboard_url
  end

  private

  def opentransact_error(e)
    flash[:error] = e.message
    redirect_to dashboard_url
  end
end
