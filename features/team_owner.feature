Feature: Team owner tasks
  In order to group my team mates together
  As a team owner
  I want to be able to manage my team
  
  Scenario: Create a new project
    Given I am logged in as the user "neiled" with the password "password"
    And I have a team called "Neil's team"
    And I am on the edit team page for "Neil's team"
    When I fill in "Project Name" with "A Project"
    And I press "Add Project"
    Then I should see "Project Added"
    And I should see "Project Name"
  
  
  
