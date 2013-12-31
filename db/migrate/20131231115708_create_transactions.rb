class CreateTransactions < ActiveRecord::Migration
  def change
    create_table :transactions do |t|
      t.string :from
      t.string :to
      t.float :amount

      t.timestamps
    end
  end
end
