class Account < ActiveRecord::Base
  has_one :pico_money
  has_many :transactions

  after_create :signup_bonus

  SIGNUP_BONUS = 100
  def signup_bonus
    if pico_money.email_md5
      PicoMoney.issuer.account.transactions.create!(
        to: pico_money.email_md5,
        amount: SIGNUP_BONUS,
        description: 'OAuth.jp Karma Signup Bonus'
      )
    end
  rescue OpenTransact::HttpException
    # ignore
  end
end
