Feature: User can delete Previous transaction

Scenario:
Given I'm logged in as "ayman.youssef@gmail.com"
And I'm on "localhost:3000/transactions"
And I can see the link "Destroy"
When I click on "Destroy"
Then I should see confirm message "Are you sure?"
Then I click on "Yes"

