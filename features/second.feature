Feature: User can search transactions based on account name

Scenario: search with account name
Given I'm on "localhost:3000/transactions"
And I can see the link "Show"
And I click on "Cash"
Then I should be on "localhost:3000/accounts/1"