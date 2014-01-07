class TransactionValidator < ActiveModel::Validator
  def validate(record)
    @accounts = Account.all
    @accounttypes = AccountType.all
    @sumassets = 0.0
    @sumequity = 0.0
    @sumliability = 0.0
    @sumexpense = 0.0
    #calcualting the SUMs without the record
    #This so that we can add the value of the record From and To to it
    @accounts.each do |account|
      case account.accounttype
      when "Asset"
        @sumassets = account.amount + @sumassets
      when "Equity"
        @sumequity = account.amount + @sumequity
      when "Liability"
        @sumliability = account.amount + @sumliability
      when "Expense"
        @sumexpense = account.amount + @sumexpense
      end
    end
    ######################################################################3
    # I want to check if the from account has the provided amount & it's not the same account as the To & the amount is not zero
    if record.from_account.amount >= record.amount.to_f && record.from_account.accounttype_id != record.to_account.accounttype_id && record.amount.to_f > 0
      # Adjusting the SUM based on the From field
      case record.from_account.accounttype_id
      when 1
        @sumassets = @sumassets - record.amount
      when 2
        @sumequity = @sumequity - record.amount
      when 3
        @sumliability = @sumliability + record.amount
      when 4
        record.errors[:from] << "Expenses can't be used to pay to other entities"
      end
      # Adjusting teh SUM based on the To field
      case record.to_account.accounttype_id
      when 1
        @sumassets = @sumassets + record.amount
      when 2
        @sumequity = @sumequity + record.amount
      when 3
        @sumliability = @sumliability - record.amount
      when 4
        @sumexpense = @sumexpense + record.amount
      end
    else
      record.errors[:base] << "Error completing this transaction"
    end

    # Checking the accounting equation
    if record.errors.empty? && @sumassets - @sumliability - @sumequity + sumexpense == 0
      return true
    else
      record.errors[:base] << "This transactions is not sound accounting"
    end
  end
end

  class Transaction < ActiveRecord::Base
    include ActiveModel::Validations
    belongs_to :from_account, :class_name => 'Account'
    belongs_to :to_account, :class_name => 'Account'
    has_many :Accounts
    validates :from, :to, :amount, presence: true
    validates_with TransactionValidator
  end
