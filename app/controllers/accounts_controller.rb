class AccountsController < ApplicationController
  def index
    @accounts_native = Account.all
  end

  def show
  end

  def new
  end

  def create
  end
end
