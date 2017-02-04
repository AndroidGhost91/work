Feature: import comments

  Background:
    Given I have created a facebook forum
    And I have created an active user
    And I log in by email
    And I have assigned an admin access token

  Scenario: comment has facebook id
    Given I have a post with comments with ids
    When I view the post
    Then the missing comments should be imported with ids

  Scenario: multiple pages
    When pending
