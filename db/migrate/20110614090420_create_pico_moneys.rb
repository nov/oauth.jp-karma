class CreatePicoMoneys < ActiveRecord::Migration
  def change
    create_table :pico_moneys do |t|
      t.belongs_to :account
      t.string :_token_, :secret, :identifier, :profile, :thumbnail
      t.timestamps
    end
  end
end
