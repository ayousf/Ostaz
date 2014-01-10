class AccountTypesController < ApplicationController
  def index
  	@accounttype = AccountType.all
  end

  def show
  	@accounttype = AccountType.find_by(params[:name])
  	@accounts = Account.all
  end

  def create
  end

  def new
  end
end
