class Account < ActiveRecord::Base
  has_and_belongs_to_many :transactions
  belongs_to :account_type
end
