  class TransactionsController < ApplicationController
  #before_action :set_transaction, only: [:show, :edit, :update, :destroy]
  before_filter :authenticate_user!
  #load_and_authorize_resource
  # GET /transactions
  # GET /transactions.json
  def index
    @transactions = Transaction.all
  end

  # GET /transactions/1
  # GET /transactions/1.json
  def show
    #if params[:id].empty? == false
    #  @transaction = Transaction.find(params[:id])
    #else
    #  @transaction = Transaction.all
    #end
    @transaction = Transaction.find(params[:id])
  end

  # GET /transactions/new
  def new
    @transaction = Transaction.new
    @accounts = Account.all
  end

  # GET /transactions/1/edit
  def edit
    @transaction = Transaction.find(params[:id])
    @accounts = Account.all
  end

  # POST /transactions
  # POST /transactions.json
  def create
    @account = Account.new
    @accounts = Account.all
    @transaction = Transaction.new()
    @transaction.id = params[:transaction][:id]
    @transaction.from_account_id = params[:transaction][:from_account_id][0].to_i
    @transaction.to_account_id = params[:transaction][:to_account_id][0].to_i
    @transaction.amount = params[:transaction][:amount]
    respond_to do |format|
      if @transaction.valid? #&& @transaction.errors.empty? == false
        @transaction.from_account.amount = @transaction.from_account.amount - @transaction.amount
        @transaction.from_account.save
        @transaction.to_account.amount = @transaction.to_account.amount + @transaction.amount
        @transaction.to_account.save
        @transaction.save
        format.html { redirect_to @transaction, notice: 'Transaction was successfully created.' }
        format.json { render action: 'show', status: :created, location: @transaction }
      else
        format.html { render action: 'new' }
        format.json { render json: @transaction.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /transactions/1
  # PATCH/PUT /transactions/1.json
  def update
    @transaction = Transaction.find(params[:id])
    @transaction.from_account_id = params[:transaction][:from_account_id][0].to_i
    @transaction.to_account_id = params[:transaction][:to_account_id][0].to_i
    @transaction.amount = params[:transaction][:amount]
    respond_to do |format|
      if @transaction.update(transaction_params)
        format.html { redirect_to @transaction, notice: 'Transaction was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @transaction.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /transactions/1
  # DELETE /transactions/1.json
  def destroy
    @transaction = Transaction.find(params[:id])
    unless @transaction.from_account_id == 3 || @transaction.from_account_id == 4
      @transaction.from_account.amount = @transaction.from_account.amount + @transaction.amount
      @transaction.from_account.save
    else
      @transaction.from_account.amount = @transaction.from_account.amount - @transaction.amount
      @transaction.from_account.save
    end
    unless @transaction.to_account_id == 3
      @transaction.to_account.amount = @transaction.to_account.amount - @transaction.amount
      @transaction.to_account.save
    else
      @transaction.to_account.amount = @transaction.to_account.amount + @transaction.amount
      @transaction.to_account.save
    end
    @transaction.destroy
    respond_to do |format|
      format.html { redirect_to transactions_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_transaction
      @transaction = Transaction.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def transaction_params
      params.require(:transaction).permit(:from, :to, :amount)
    end
  end
