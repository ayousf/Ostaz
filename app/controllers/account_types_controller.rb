class AccountTypesController < ApplicationController
  def index
  	@accounttype = AccountType.all
  end

  def show
  	@accounttype = AccountType.find(params[:id])
    puts ">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>"
    puts "@accounttype contains the following #{@accounttype.name}"
    puts "<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<"
  	@accounts = Account.all
  end

  def create
  end

  def new
  end
end
