class CreateTransactions < ActiveRecord::Migration
  def change
    create_table :transactions do |t|
      t.belongs_to :account
      t.integer :amount, default: 1
      t.string :to, :description
      t.boolean :completed, default: false
      t.timestamps
    end
  end
end
