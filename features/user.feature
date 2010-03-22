Feature: Users should be able to update their details
  In order to keep up to date with a user's changing details, or to correct mistakes
  As a member of the site
  I want to be able to update my username, full name, email address and password

  Background:
    Given the following users
    | login  | team |
    | neiled |      |
    And I am logged in as the user "neiled"
    And I am on the user account page for "neiled"
    And I follow "edit my details"    

  Scenario: Update a users display name
    When I fill in "display name" with "Bob Bobson"
    And I press "Save"
    Then the user "neiled" should have the full name "Bob Bobson"

  Scenario: Update a users email address
    When I fill in "email" with "bob@bobson.com"
    And I press "Save"    
    Then the user "neiled" should have the email adddress "bob@bobson.com"

  
  
  