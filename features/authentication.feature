Feature: Authentication
  In order to be able to assign users to teams and projects to users
  As a new visitor to the website
  I want to be able to create an account and log in and out
  
  Scenario: Create a new account
    Given I am on the registration page
    When I fill in "login" with "neiled"
    And I fill in "password" with "password"
    And I fill in "password confirmation" with "password"
    And I press "Create Account"
    Then I should be on the user account page
    And there should be 1 user
  
  
  

  
