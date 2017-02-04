Feature: inbound email

  Background:
    Given I have created multiple users

  Scenario: TO email address
    When I send an email to "bob+randomhashhere@czardom.com" from "alice@example.com"
    Then a conversation should be started for "alice"
    And a conversation should be created for "bob"

  Scenario: CC email address
    When I CC an email to "bob+randomhashhere@czardom.com" from "alice@example.com"
    Then a conversation should be started for "alice"
    And a conversation should be created for "bob"

  Scenario: BCC email address
    When I BCC an email to "bob+randomhashhere@czardom.com" from "alice@example.com"
    Then a conversation should be started for "alice"
    And a conversation should be created for "bob"

  Scenario: has stripped reply
    When I reply to an email to "bob+randomhashhere@czardom.com" from "alice@example.com"
    Then a conversation should be started for "alice" with the reply
    And a conversation should be created for "bob" with the reply

  Scenario: TO multiple addresses
    When I send an email to multiple users from "alice@example.com"
    Then a conversation should be started for "alice"
    And a conversation should be created for "bob"
    And a conversation should be created for "george"

  Scenario: TO, CC, and BCC multiple addresses
    When I send an email to multiple users with cc and bcc from "alice@example.com"
    Then a conversation should be started for "alice"
    And a conversation should be created for "bob"
    And a conversation should be created for "george"
    And a conversation should be created for "steve"

  Scenario: sender doesn't exist in database
    When I send an email to "bob+randomhashhere@czardom.com" from "the.pope@example.com"
    Then a conversation should be started for "mail-agent" with the sender email
    And a conversation should be created for "bob"
