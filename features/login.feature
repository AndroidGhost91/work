Feature: login

  Scenario: login by email
    Given I have created an active user
    When I log in by email
    Then I should be taken to my account

  Scenario: login with invalid email
    Given I have created an active user
    When I log in with a missing email
    Then I should receive a login error
