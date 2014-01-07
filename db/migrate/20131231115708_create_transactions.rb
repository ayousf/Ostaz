class CreateTransactions < ActiveRecord::Migration
  def change
    create_table :transactions do |t|
      t.references :from_account
      t.references :to_account
      t.float :amount

      t.timestamps
    end

  end
end
