Feature: Forgotten Password Resetting
  In order to be able to carry on using the site
  As a user of the site
  I want to be able to reset my password if I forget it
  
  Background:
    Given the following users
    | login  | team      |
    | neiled | neils     |
    | bob    |           |

  Scenario: During login user forgets their password
    Given I am on the login page
    When I follow "forgotten your password?"
    Then I should be on the forgotten password page
  
  Scenario: Entering email address of unknown user should get error
    Given I am on the forgotten password page
    When I press "Submit"
    Then I should see "Are you sure that's your email address?"
    
  Scenario: Entering email of known user should get email with reset instructions
    Given I am on the forgotten password page
    When I fill in "email" with "neiled@plasticwater.com"
    And I press "Submit"
    Then I should see "We've emailed you some password reset instructions!"
    And I should be on the login page
    And "neiled@plasticwater.com" opens the email with subject "Busywith.com - Reset your password"
    Then they should see "tried to get your password reset on busywith.com." in the email body
    
  Scenario: Going to reset url should allow user to reset their password
    Given the user "neiled" has forgotten their password
    When I go to the password reset page for "neiled"
    And I fill in "password" with "test123"
    And I fill in "password confirmation" with "test123"
    And I press "Submit"
    Then I should see "We've updated your password"
  
  
  
  
  
  
  
  
  
  
  
