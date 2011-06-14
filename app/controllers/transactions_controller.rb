class TransactionsController < ApplicationController
  before_filter :require_authentication

  def create
    current_account.transactions.create!(params[:transaction])
  rescue OpenTransact::HttpException => e
    flash[:error] = e.message
  ensure
    redirect_to dashboard_url
  end
end
