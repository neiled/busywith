Feature: Workers should be able to create a team
  In order to see what my team mates are up to
  As a team leader
  I want to be able to generate a team and add team members to it
  
  Scenario: Create a new team
    Given I am logged in as the user "neiled" with the password "secret"
    And I am on the new team page
    When I fill in "Team Name" with "Neil's team"
    And I press "Create Team"
    Then I should have a team called "Neil's team"
  
  
   

  
