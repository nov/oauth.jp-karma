class CreatePicoMoneys < ActiveRecord::Migration
  def change
    create_table :pico_moneys do |t|
      t.belongs_to :account
      t.string :access_token, :access_token_secret, :identifier, :profile, :thumbnail
      t.timestamps
    end
  end
end
