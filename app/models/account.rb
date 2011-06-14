class Account < ActiveRecord::Base
  has_one :pico_money
  has_many :transactions
end
