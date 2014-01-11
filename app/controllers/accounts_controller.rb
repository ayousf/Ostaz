class AccountsController < ApplicationController
  def index
    @accounts_native = Account.all
  end

  def show
  	@account = Account.find(params[:id])
  	@transaction = Transaction.all
  end

  def new
    @accounttype = AccountType.all
    @account = Account.new
  end

  def create
    @account = Account.new()
    @account.name = params[:account][:name]
    @account.account_type_id = params[:account][:account_type_id][0].to_i
    #@account.id = params[:account][:id]
    @account.amount = params[:account][:amount]
    respond_to do |format|
      if @account.valid?
        @account.save
        format.html {redirect_to @account, notice: 'Account was succesfully created'}
        format.json {render action: 'show', status: created, location:@account}
      else
        format.html {render action: 'new'}
        format.json {render json: @account.errors, status: unprocessable_entity}
      end
    end
  end

  def destroy
    @account = Account.find(params[:id])
    if @account.amount == 0
      @account.destroy
      respond_to do |format|
        format.html {redirect_to accounts_path}
        format.json {head :no_content}
      end
    end
  end

end
