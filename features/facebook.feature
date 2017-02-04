Feature: facebook auth

  Scenario: with an existing account
    Given I have an existing account in place
    When I login to my existing account through facebook
    Then I should be logged in

  Scenario: without email
    When I login with facebook without my email
    Then I should receive an error that registration has ended

  Scenario: without location
    When I login with facebook without my location
    Then I should receive an error that registration has ended

  Scenario: without education
    When I login with facebook without my education
    Then I should receive an error that registration has ended

  Scenario: without website
    When I login with facebook without my website
    Then I should receive an error that registration has ended

  Scenario: without personal description
    When I login with facebook without my personal description
    Then I should receive an error that registration has ended

  Scenario: connect to facebook with email account
    Given I have created an active user
    When I log in by email
    And I connect my account to facebook
    Then my account connection should be updated

  # @wip
  # Scenario: add password during sign up
  #   When I login with facebook with a complete account
  #   Then I should be asked to fill in a password
