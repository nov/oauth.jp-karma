class CreatePicoMoneys < ActiveRecord::Migration
  def change
    create_table :pico_moneys do |t|
      t.belongs_to :account
      t.string :token, :secret, :identifier, :email_md5, :profile, :thumbnail
      t.timestamps
    end
  end
end
