class Account < ActiveRecord::Base
  has_many :transactions
  belongs_to :account_types
end
