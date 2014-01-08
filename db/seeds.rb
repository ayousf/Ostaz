# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
@nuaccounts = [{:name => "Cash", :amount => 250000, :accounttype_id => 1}, {:name => "Bank", :amount => 0.0, :accounttype_id => 1}, {:name => "Equipment", :amount => 0.0, :accounttype_id => 1}, {:name => "Capital", :amount => 250000, :accounttype_id => 3}, {:name => "Office Expenses", :amount => 0.0, :accounttype_id => 4}]
@nuaccounts.each do |x|
  Account.create(x)
end
@nuaccount_types = [{:name => "Asset"}, {:name => "Liability"}, {:name => "Equity"},  {:name => "Expense"}]
@nuaccount_types.each do |y|
  AccountType.create(y)
end

