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
    Then I should be on the user account page for "neiled"
    And there should be 1 user

  @error  
  Scenario: Logging in
    Given I have a user with the username "neiled" and the password "secret"
    And I am on the login page
    When I fill in "login" with "neiled"
    And I fill in "password" with "secret"
    And I press "Login"
    Then I should be on the user account page for "neiled"
    And I should see "Logged in"
    And I should see "Log out"
    
  Scenario: Logging out
    Given I have a user with the username "neiled" and the password "secret"
    And I am logged in as the user "neiled"
    And I am on the homepage
    When I follow "Log out"
    Then I should be logged out
    
  
  
  
  
  

  
