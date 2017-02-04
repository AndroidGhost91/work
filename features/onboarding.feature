Feature: onboarding users
  In order improve user happiness during sign up
  I want to walk them through following and recommending czars
  And joining and recommending groups
  And adding their clients

  Background:
    Given I have a default list of users
    And I have created several groups

  Scenario: onboarding state
    When I create an account
    Then I should be in the onboarding groups stage

  Scenario: auto follow users
    When I create an account
    Then I should be automatically following default users

  Scenario: recommend groups
    When I create an account
    Then I should be taken to pick groups
    And I should be in the active stage
    And I should be taken to the complete page
    # And I should be in the onboarding clients stage

  Scenario: add clients
    When pending
    When I create an account
    Then I enter client information
    And I should be in the active stage
    And I should be taken to the complete page

  @javascript
  Scenario: updating information
    When I create an account with missing information
    Then I should be taken to pick groups
    And I should be taken to fill in my missing information
    And I should be in the active stage
    And I should be taken to the complete page
