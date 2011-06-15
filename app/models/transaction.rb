class Transaction < ActiveRecord::Base
  extend ActiveSupport::Memoizable
  delegate :config, :organization, :transaction_url, to: PicoMoney

  validates :account_id, presence: true
  validates :to, presence: true, email: true
  validates :amount, numericality: {greater_than: 0,  less_than_or_equal_to: 100}

  after_create :transfer!

  def transfer!
    asset.transfer(amount, to, description)
    update_attributes!(completed: true)
  end

  private

  def client
    OpenTransact::Client.new(
      config.merge(
        token:  organization.token,
        secret: organization.secret
      )
    )
  end
  memoize :client

  def asset
    OpenTransact::Asset.new(
      transaction_url,
      client: client
    )
  end
  memoize :asset

end
