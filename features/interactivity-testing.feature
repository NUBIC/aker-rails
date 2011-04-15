@wip
Feature: Interactivity testing
  Scenario: Interactive requests are deemed interactive
    When I am using the user interface

    Then the request is deemed interactive

  Scenario: Non-interactive requests are deemed non-interactive
    When I am using the API

    Then the request is deemed non-interactive
