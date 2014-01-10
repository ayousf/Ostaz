class AccountType < ActiveRecord::Base
  has_many :accounts
  include ActiveModel::Validations
  validates :name, presence: true
  validates :name, uniqueness: true
  validates :name, length: {in: 2..20}
  validates :name, numericality: false
end
