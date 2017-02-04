Feature: html sanitization

  Background:
    Given I have created an active user
    When I log in by email

  Scenario: blank html
    Given I have a nil about me
    Then my profile bio should be blank

  Scenario: user about you
    Given I'm editing my account
    When I enter unsafe html into "About You"
    And I submit the html form
    Then only safe content should be in ".bio"

  Scenario: general topic
    Given I'm creating a new post
    When I enter unsafe html into "Message"
    And I submit the html form
    Then only safe content should be included in post response

  Scenario: event description
    Given I'm creating a new event
    When I enter unsafe html into "Description"
    And I submit the html form
    Then only safe content should be in ".event-description"
