Feature: reset password

  @javascript
  Scenario: reset password with invalid record
    Given I have an account with invalid data
    When I reset my password
    Then I should be able to log in
