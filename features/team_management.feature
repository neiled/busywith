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
    Given I am logged in as the user "neiled"
    And I am on the team page for "neils"
    When I fill in "username" with "bob"
    And I press "Invite"
    Then the user "bob" should have an invite to the team "neils"
    
  Scenario: See invite waiting for user
    Given I am logged in as the user "bob"
    And the user "bob" has an invite for the team "neils"
    When I am on the user account page for "bob"    
    Then I should see "neils"
    And I should see "Accept"
    And I should see "Ignore"
    
  Scenario: Accept an invite to a team
    Given I am logged in as the user "bob"
    And the user "bob" has an invite for the team "neils"
    When I am on the user account page for "bob"
    And I follow "Accept"
    Then I should see "Invite Accepted"
    And the user "bob" should be a member of the team "neils"
    
    
  Scenario: Invite someone who does not exist
    Given I am logged in as the user "neiled"
    And I am on the team page for "neils"
    When I fill in "username" with "foo"
    And I press "Invite"
    Then I should see "Unknown user"
      
  Scenario: Hack the team_id field
    Given I am logged in as the user "neiled"
    And I am on the team page for "neils"
    When I fill in "username" with "foo"
    And I change the hidden field "team_id" to "0"
    And I press "Invite"
    Then I should see "You do not own that team"     
  
  
  

  
