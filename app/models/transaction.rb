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
        @sumassets = account.amount.to_f + @sumassets
      when "Equity"
        @sumequity = account.amount.to_f + @sumequity
      when "Liability"
        @sumliability = account.amount.to_f + @sumliability
      when "Expense"
        @sumexpense = account.amount.to_f + @sumexpense
      end
    end
    # calculating the SUMs based on the information in the record
    @accounts.each do |account|
      if account.name == record.from
        case account.accounttype
        when "Assets"
          @sumassets = @sumassets - record.amount.to_f
        when "Equity"
          @sumequity = @sumequity - record.amount.to_f
        when "Liability"
          record.errors[:base] = "The FROM record can't be of type LIABILITY"
        when "Expense"
          record.errors[:base] = "The FROM record can't be of type EXPENSE"
        end
        elsif account.name == record.to
          case account.accounttype
          when "Assets"
            @sumassets = @sumassets + record.amount.to_f
          when "Equity"
            @sumequity = @sumequity + record.amount.to_f
          when "Liability"
            @sumliability = @sumliability + record.amount.to_f
          when "Expense"
            @sumexpense = @sumexpense + record.amount.to_f
          end
      end
    end
    
    #Applying the formula to check it transaction is valid or not
    if @sumassets - @sumliability - @sumequity + @sumexpense != 0.0
     record.errors.add(:base, "This is not a valid transaction")
     #record.errors = "This is not a valid transaction"
    end
    
  end
end


class Transaction < ActiveRecord::Base
  include ActiveModel::Validations
  #include ActiveModel::Errors
  has_and_belongs_to_many :accounts
  
  validates :from, :to, :amount, presence: true
  validates_with TransactionValidator
  
end
