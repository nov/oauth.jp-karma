class TransactionsController < ApplicationController
  before_filter :require_authentication

  def create
    transaction = current_account.transactions.create!(params[:transaction])
    redirect_to dashboard_url, notice: {
      title: 'flash.title.transaction_completed'.t,
      text: 'flash.description.transaction_completed'.t(
        amount: transaction.amount,
        to:     transaction.to
      ),
      image: PicoMoney.issuer.thumbnail
    }
  end
end
