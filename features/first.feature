Feature: User can add new accounts

Scenario: adding accounts
Given I'm on "localhost:3000/transactions"
And I click on link "Add new Accounts"
Then I fill in "Name" with "Accounts Receivable"
And fill in "Amount" with "50000"
And select "1 - Asset" from "Account type" 
And I click on "Create Account"
Then I should see the heading "Account Detials"
Then I click on "Back to transactions homepage"
Then I  click on "View Accounts"
Then I should see table data "Accounts Receivable"

