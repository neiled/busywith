Feature: Email support
  In order to better communicate with customers
  As a site administrator
  I want to be able to confirm that the email address entered at sign up is valid

  Background:
    Given the following users
    | login  | team  |
    | bob    |       |
    | neil   | neils |
  
  Scenario: When a new person signs up they get an email sent
      When "bob@plasticwater.com" opens the email
      Then I should see "Hello bob" in the email body

  Scenario: When a team owner adds an existing user that user should get an email notifying them 
    Given I am logged in as the user "neil"
    And I am on the edit team page for "neils"
    When I fill in "email" with "bob@plasticwater.com"
    And I press "Invite"
    And "bob@plasticwater.com" opens the email with subject "Team Invite - busywith.com"
    Then they should see "neil has invited you to the team 'neils'" in the email body
  
  
  Scenario: When a team owner adds a user that doesn't exist then create the temp user and email them
    Given I am logged in as the user "neil"
    And I am on the edit team page for "neils"
    When I fill in "email" with "john@plasticwater.com"
    And I press "Invite"
    And "john@plasticwater.com" opens the email with subject "Team Invite from busywith.com"
    Then they should see "Someone at busywith.com \(Neil Edwards\) wants you to be in their team" in the email body
    When I follow "Sign up!" in the email
    Then I should be on the registration page