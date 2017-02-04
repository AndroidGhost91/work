Feature: paypal purchase

  Background:
    Given I have created an active user
    When I log in by email

  Scenario: complete page
    When I view the confirmation page for token "EC-2AN49353U9175042X"
    Then the paypal details should be displayed
    When complete the purchase
    Then the payola sale should be created with paypal details

  Scenario: invalid token
    When I view the confirmation page for token "EC-7TW00152W6292824U"
    And complete the purchase
    Then an error message should be displayed
