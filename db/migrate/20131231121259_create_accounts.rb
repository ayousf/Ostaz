class CreateAccounts < ActiveRecord::Migration
  def change
    create_table :accounts do |t|
      t.string :name
      t.float :amount
      t.belongs_to :accounttype
      

      t.timestamps
    end
  end
end
