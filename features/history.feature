Feature: Show history of previous actions
  In order to be able to get an idea about what people are doing in the team
  As a manager or team member
  I want to be able to see what people have done in the recent past

  Background:
    Given the following users
    | login  | team      |
    | neiled | neils     |
    | bob    |           |
  
  Scenario: Changing Status should show in the history
    Given I am logged in as the user "neiled"
    And I am on the user account page for "neiled"
    When I fill in "Current Task" with "Testing out the history"
    And I press "Update"
    Then I should see "updated their current task to 'Testing out the history'"
  
  Scenario: Accept an invite to a team
    Given I am logged in as the user "bob"
    And the user "bob" has an invite for the team "neils"
    When I am on the user account page for "bob"
    And I follow "Accept"
    Then I should see "joined the team 'neils'"
  
  
