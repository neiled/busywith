Feature: Authentication
  In order to be able to assign users to teams and projects to users
  As a new visitor to the website
  I want to be able to create an account and log in and out
  
  Scenario: Create a new account
    Given I am on the registration page
    When I fill in "login" with "neiled"
    And I fill in "email" with "neil@plasticwater.com"
    And I fill in "first name" with "Neil"
    And I fill in "last name" with "Edwards"
    And I fill in "password" with "password"
    And I fill in "password confirmation" with "password"
    And I press "Sign up"
    Then I should be on the user account page for "neiled"
    And there should be 1 user

  Scenario: Logging in
    Given I have a user with the username "neiled" and the password "secret"
    And I am on the login page
    When I fill in "login" with "neiled"
    And I fill in "password" with "secret"
    And I press "Sign in"
    Then I should be on the user account page for "neiled"
    And I should see "You are now signed in"
    And I should see "Sign out"
    
  Scenario: Logging out
    Given I have a user with the username "neiled" and the password "secret"
    And I am logged in as the user "neiled"
    And I am on the homepage
    When I follow "Sign out"
    Then I should be logged out
    
  Scenario: Don't allow login with spaces in it
    Given I am on the registration page
    When I fill in "login" with "this is a test"
    And I fill in "email" with "neil@plasticwater.com"
    And I fill in "password" with "password"
    And I fill in "password confirmation" with "password"
    And I press "Sign up"
    #Then I should be on the registration page
    #We can't see if we're on the registration page because rails just sends us to /users/ rather than /users/new
    Then I should see "should use only letters, numbers and .-_@ please."
    
  Scenario: Don't allow login with html in it
    Given I am on the registration page
    When I fill in "login" with "<script>alert('hello');</script>"
    And I fill in "email" with "neil@plasticwater.com"
    And I fill in "password" with "password"
    And I fill in "password confirmation" with "password"
    And I press "Sign up"
    Then I should see "should use only letters, numbers and .-_@ please."    

  Scenario: Don't allow short logins
    Given I am on the registration page
    When I fill in "login" with "a"
    And I fill in "email" with "neil@plasticwater.com"
    And I fill in "password" with "password"
    And I fill in "password confirmation" with "password"
    And I press "Sign up"
    Then I should see "Login is too short"

    