class Account < ActiveRecord::Base
  belongs_to :transaction
  belongs_to :account_type
end
