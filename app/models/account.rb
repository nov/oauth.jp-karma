class Account < ActiveRecord::Base
  has_one :pico_money
  has_many :transactions

  after_create :signup_bonus

  SIGNUP_BONUS = 100
  def signup_bonus
    PicoMoney.issuer.account.transactions.create!(
      to: pico_money.email_md5,
      amount: SIGNUP_BONUS,
      description: ''
    )
  rescue OpenTransact::HttpException
    # ignore
  end
end
