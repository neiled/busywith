Feature: Email support
  In order to better communicate with customers
  As a site administrator
  I want to be able to confirm that the email address entered at sign up is valid

  Background:
    Given the following users
    | login  | team  |
    | bob    |       |
  
  Scenario: When a new person signs up they get an email sent
      When "bob@plasticwater.com" opens the email
      Then I should see "Hello bob" in the email body
