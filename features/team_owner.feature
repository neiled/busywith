Feature: Team owner tasks
  In order to group my team mates together
  As a team owner
  I want to be able to manage my team
  
  Background:
    Given the following users
    | login  | team  |
    | neiled |       |
  
  Scenario: Create a new project
    Given I am logged in as the user "neiled"
    And I have a team called "Neil's team"
    And I am on the edit team page for "Neil's team"
    When I follow "Add Project"
    And I fill in "Project Name" with "A Project"
    And I press "Add Project"
    Then I should see "Project Added"
    And I should see "A Project"
    
  Scenario: Delete an existing project
    Given I am logged in as the user "neiled"
    And I have a team called "Neil's team" with a project called "A Project"
    And I am on the edit team page for "Neil's team"
    And I follow "Delete Project"
    Then I should see "Project Deleted"
    And I should not see "A Project"
  
  Scenario: See the list of teams I'm a member of
    Given I am logged in as the user "neiled"
    And I have a team called "Neil's team"
    And I am on the user account page for "neiled"
    Then I should see "Neil's team"
    
  Scenario: Show if I'm not a member of any team
    Given I am logged in as the user "neiled"
    And I am on the user account page for "neiled"
    Then I should see "not a member of any team"
    
  Scenario: Delete an existing team
    Given I am logged in as the user "neiled"
    And I have a team called "Neil's team"
    And I am on the user account page for "neiled"
    And I follow "Delete Team"
    Then I should see "Team Deleted"
    And I should see "not a member of any team"
  
  
      