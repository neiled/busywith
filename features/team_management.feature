Feature: Manage teams
  In order to group workers together
  As a team owner
  I want to be able to invite and kick out team members
  
  Background:
    Given the following users
    | login  | team  |
    | neiled | neils |
    | bob    |       |
  
  Scenario: Invite new members
    And I am logged in as the user "neiled"
    And I am on the team page for "neils"
    When I fill in "username" with "bob"
    And I press "Invite"
    Then the user "bob" should have an invite to the team "neils"
    
  Scenario: Invite someone who does not exist
    And I am logged in as the user "neiled"
    And I am on the team page for "neils"
    When I fill in "username" with "foo"
    And I press "Invite"
    Then I should see "Unknown user"
      
  Scenario: Hack the team_id field
    And I am logged in as the user "neiled"
    And I am on the team page for "neils"
    When I fill in "username" with "foo"
    And I change the hidden field "team_id" to "0"
    And I press "Invite"
    Then I should see "You do not own that team"     
  
  
  

  
