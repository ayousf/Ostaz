class Transaction < ActiveRecord::Base
  has_and_belongs_to_many :accounts
  
  validates :from, :to, :amount, presence: true
  
end
