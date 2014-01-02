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
      puts "@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@"
      puts "started an iteration from account.each"
      puts "@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@"
      if account.name == record.from 
        puts "$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$"
        puts "started an if statement investigation -- first if statement"
        puts "$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$"
        case account.accounttype
        when "Asset"
          if account.amount > 0 && account.amount >= record.amount
            @sumassets = @sumassets - record.amount
          #account.amount = account.amount - record.amount
          #account.save
          else
            record.errors[:from] << "#{record.from} doesn't have enough money to complete this transaction"
          end
        when "Equity"
          if account.amount > 0 && account.amount >= record.amount
            @sumequity = @sumequity - record.amount
          #account.amount = account.amount - record.amount
          #account.save
          else
            record.errors[:from] << "#{record.from} doesn't have enough money to complete this transaction"
          end
        when "Liability"
          if account.amount > 0 && account.amount >= record.amount
            @sumliability = @sumliability - record.amount
          #account.amount = account.amount - record.amount
          #account.save
          else
            record.errors[:from] << "#{record.from} doesn't have enough money to complete this transaction"
          end
        when "Expense"
          record.errors[:from] << "The FROM record can't be of type EXPENSE"
        end
      elsif account.name == record.to && account.name != record.from
        puts "%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%"
        puts "entered into the elsif statemetns"
        puts "%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%"
        case account.accounttype
        when "Assets"
          @sumassets = @sumassets + record.amount
          #account.amount = account.amount + record.amount
          #account.save
        when "Equity"
          @sumequity = @sumequity + record.amount
          #account.amount = account.amount + record.amount
          #account.save
        when "Liability"
          @sumliability = @sumliability + record.amount
          #account.amount = account.amount + record.amount
          #account.save
        when "Expense"
          @sumexpense = @sumexpense + record.amount
          #account.amount = account.amount + record.amount
          #account.save
        end
      end
    end
    #@accounts.save
    #Applying the formula to check it transaction is valid or not
    puts "************************************************"
    puts "just before the last if statement"
    puts "the values of summations are as follows"
    puts @sumassets
    puts @sumliability
    puts @sumequity
    puts @sumexpense
    puts "***********************************************"
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
