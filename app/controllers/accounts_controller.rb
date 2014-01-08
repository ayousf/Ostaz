class AccountsController < ApplicationController
  def index
    @accounts_native = Account.all
  end

  def show
  	@account = Account.find(params[:id])
  	@transaction = Transaction.all
  end

  def new
  end

  def create
  end
end
