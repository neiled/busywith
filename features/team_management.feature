Feature: Manage teams
  In order to group workers together
  As a team owner
  I want to be able to invite and kick out team members
  
  Background:
    Given the following users
    | login  | team  |
    | neiled | neils |
    | fred   |       |
    | bob    |       |

  Scenario: Invite existing members
    Given I am logged in as the user "neiled"
    And I am on the edit team page for "neils"
    When I fill in "email" with "Bob@plasticwater.com"
    And I press "Invite"
    Then the user "bob" should have an invite to the team "neils"
    
  Scenario: Shouldn't be able to invite an existing team member
    Given I am logged in as the user "neiled"
    And I am on the edit team page for "neils"
    When I fill in "email" with "Bob@plasticwater.com"
    And I press "Invite"
    Then the user "bob" should have an invite to the team "neils"    
    Given I am on the edit team page for "neils"
    When I fill in "email" with "Bob@plasticwater.com"
    And I press "Invite"
    Then I should see "already has an invite to your team"
        
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
    
  Scenario: Decline an invite to a team
    Given I am logged in as the user "bob"
    And the user "bob" has an invite for the team "neils"
    When I am on the user account page for "bob"
    And I follow "Ignore"
    Then I should see "Invite Ignored"
    And the user "bob" should not be a member of the team "neils"
    And the user "bob" should not have an invite to for the team "neils"
    And the user "bob" should not have an event message "left the team"
    
  Scenario: Leave a team
    Given I am logged in as the user "bob"
    And the user "bob" is a member of the team "neils"
    When I am on the user account page for "bob"
    And I follow "Leave this team!"
    Then I should see "You are no longer a member of the team neils"
    And the user "bob" should not be a member of the team "neils"
    And the user "bob" should not have an invite to for the team "neils"
  
  Scenario: Remove someone from the team
    Given I am logged in as the user "neiled"    
    And the user "bob" is a member of the team "neils"
    And I am on the edit team page for "neils"
    When I follow "Remove"
    Then I should see "Bob has been removed from the team"
    And the user "bob" should not be a member of the team "neils"
    
  Scenario: Remove an invitation from someone who hasn't yet accepted
    Given I am logged in as the user "neiled"    
    And the email "foo@example.com" has an invite for the team "neils"
    And I am on the edit team page for "neils"
    When I follow "Remove"
    Then I should see "You've withdrawn your invite"
    And the user with the email "foo@example.com" should not have an invite to the team "neils"
    
  Scenario: Delete a team
    Given I am logged in as the user "neiled"
    And I am on the user account page for "neiled"
    When I follow "Disband this team!"
    Then I should see "Team Deleted."
    And the user "neiled" should not be a member of the team "neils"

  Scenario: Invite someone who does not exist
    Given I am logged in as the user "neiled"
    And I am on the edit team page for "neils"
    When I fill in "email" with "foo@plasticwater.com"
    And I press "Invite"
    Then I should see "sent them an email"
    Given I have a user with the username "foo" and the password "password"
    And I am logged in as the user "foo"
    When I am on the user account page for "foo"
    Then I should see "You have an invite to the team neils"

      
  Scenario: Hack the team_id field
    Given I am logged in as the user "neiled"
    And I am on the edit team page for "neils"
    When I fill in "email" with "foo"
    And I change the hidden field "team_id" to "0"
    And I press "Invite"
    Then I should see "You do not own that team"     
  
  Scenario: See a team whilst not logged in
    Given I am on the edit team page for "neils"
    Then I should see "must be signed in"

  Scenario: Shouldn't be able to add more than one team
    Given I am logged in as the user "neiled"
    And I have a team called "neils"
    And I am on the user account page for "neiled"
    Then I should not see "Create a new team"

  Scenario: Non members shouldn't be able to see members pages
    Given I am logged in as the user "bob"
    When I am on the user account page for "neiled"
    Then I should see "do not have permission"
    
  Scenario: Members should see the users status
    Given I am logged in as the user "fred"
    And the user "fred" is a member of the team "neils"
    When I am on the user account page for "neiled"
    Then I should see "Status for"
  
  
  
  
  
  
    