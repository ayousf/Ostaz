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
    # calculating the SUMs based on the information in the record
    @accounts.each do |account|
      if account.name == record.from 
        case account.accounttype
        when "Asset"
          if account.amount > 0 && account.amount >= record.amount.to_f
            @sumassets = @sumassets - record.amount.to_f
          #account.amount = account.amount - record.amount
          #account.save
          else
            record.errors[:from] << "#{record.from} doesn't have enough money to complete this transaction"
          end
        when "Equity"
          if account.amount > 0 && account.amount >= record.amount.to_f
            @sumequity = @sumequity - record.amount.to_f
          #account.amount = account.amount - record.amount
          #account.save
          else
            record.errors[:from] << "#{record.from} doesn't have enough money to complete this transaction"
          end
        when "Liability"
          if account.amount > 0 && account.amount >= record.amount.to_f
            @sumliability = @sumliability - record.amount.to_f
          #account.amount = account.amount - record.amount
          #account.save
          else
            record.errors[:from] << "#{record.from} doesn't have enough money to complete this transaction"
          end
        when "Expense"
          record.errors[:from] << "The FROM record can't be of type EXPENSE"
        end
    end
    @accounts.each do |account|
      if account.name == record.to && account.name != record.from
        case account.accounttype
        when "Asset"
          @sumassets = @sumassets + record.amount.to_f
          #account.amount = account.amount + record.amount
          #account.save
        when "Equity"
          @sumequity = @sumequity + record.amount.to_f
          #account.amount = account.amount + record.amount
          #account.save
        when "Liability"
          @sumliability = @sumliability + record.amount.to_f
          #account.amount = account.amount + record.amount
          #account.save
        when "Expense"
          @sumexpense = @sumexpense + record.amount.to_f
          #account.amount = account.amount + record.amount
          #account.save
        end
      end
    
    #Applying the formula to check it transaction is valid or not
    # Cash (Asset) = 250,000
    # Bank (Asset) = 0
    # Equipment (Asset) = 0
    # Capital (Equity) = 250,000
    # Office Expenses (Expense) = 0
    if @sumassets - @sumliability - @sumequity + @sumexpense != 0.0
      record.errors.add(:base, "This is not a valid transaction")
    #record.errors = "This is not a valid transaction"
    else
     @accounts.each do |account|
       if account.name == record.from
         account.amount = account.amount - record.amount.to_f
         account.save
       elsif account.name == record.to
         account.amount = account.amount + record.amount.to_f
         account.save
       end
     end
    end
  end
end

class Transaction < ActiveRecord::Base
  include ActiveModel::Validations
  has_and_belongs_to_many :accounts
  validates :from, :to, :amount, presence: true
  validates_with TransactionValidator
end
