class CreateTransactions < ActiveRecord::Migration
  def change
    create_table :transactions do |t|
      t.belongs_to :accounts
      t.belongs_to :accounts
      t.float :amount

      t.timestamps
    end
  end
end
