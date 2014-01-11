class AccountTypesController < ApplicationController
  def index
  	@accounttype = AccountType.all
  end

  def show
  	@accounttype = AccountType.find(params[:id])
  	@accounts = Account.all
  end

  def create
    @accounttype = AccountType.new
    @accounttype.name = params[:account_type][:name]
    respond_to do |format|
      if @accounttype.valid?
        @accounttype.save
        format.html { redirect_to @accounttype, notice: 'Account Type was successfully created.' }
        format.json { render action: 'show', status: :created, location: @accounttype }
      else
        format.html { render action: 'new' }
        format.json { render json: @accounttype.errors, status: :unprocessable_entity }
      end
    end
  end

  def new
    @accounttype = AccountType.new()
  end

  def destroy
    @found = false
    @accounttype = AccountType.find(params[:id])
    @accounts = Account.all
    @accounts.each do |account|
      if account.account_type_id == @accounttype.id
        @found = true
      end
    end
    if @found == false
      @accounttype.destroy
      respond_to do |format|
        
        format.html{ redirect_to account_types_url}    
        format.json{ head :no_content}
      end
    end
  end

end
