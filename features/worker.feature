Feature: Workers should be able to create a team
  In order to see what my team mates are up to
  As a team leader
  I want to be able to generate a team and add team members to it
  
  Background:
    Given the following users
    | login  | team |
    | neiled |      |
  
  Scenario: Create a new team
    Given I am logged in as the user "neiled"
    And I am on the user account page for "neiled"
    And I follow "Create a new team"
    When I fill in "Team Name" with "Neil's team"
    And I press "Create Team"
    Then the user "neiled" should be an administrator of a team called "Neil's team"

  Scenario: Update current task
    Given I am logged in as the user "neiled"
    And I have a team called "Neil's team" with a project called "Test Project"
    And I am on the user account page for "neiled"    
    When I fill in "Current Task" with "Performing a test"
    And I press "Update"
    Then the "Current Task" field should contain "Performing a test"
    And I should see "Status Updated"

  Scenario: Update current project
    Given I am logged in as the user "neiled"
    And I have a team called "Neil's team" with a project called "Test Project"
    And I am on the user account page for "neiled"    
    When I select "Test Project" from "Project"
    And I press "Update"
    Then "Test Project" should be selected for "Project"
    And I should see "Status Updated"
    
  Scenario: Update estimated completion
    Given I am logged in as the user "neiled"
    And I have a team called "Neil's team" with a project called "Test Project"
    And I am on the user account page for "neiled"    
    When I fill in "Due" with "01 Jan 2020"
    And I press "Update"
    Then the "Due" field should contain "01 Jan 2020"    
    And I should see "Status Updated"  
  