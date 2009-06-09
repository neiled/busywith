Feature: Team owner tasks
  In order to group my team mates together
  As a team owner
  I want to be able to manage my team
  
  Scenario: Create a new project
    Given I am logged in as the user "neiled" with the password "password"
    And I have a team called "Neil's team"
    And I am on the edit team page for "Neil's team"
    When I follow "Add Project"
    And I fill in "Project Name" with "A Project"
    And I press "Add Project"
    Then I should see "Project Added"
    And I should see "A Project"
    
  Scenario: Delete an existing project
    Given I am logged in as the user "neiled" with the password "password"
    And I have a team called "Neil's team"
    And I have a project called "A Project"
    And I am on the edit team page for "Neil's team"
    And I follow "Delete Project"
    Then I should see "Project Deleted"
    And I should not see "A Project"
  
  
  
  
  
  
