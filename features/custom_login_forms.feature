Feature: Custom login forms
  To present a singular look and feel
  Application developers
  want to be able to use custom pages for form authentication.

  Background:
    Given I am using the user interface

  Scenario: Customizing the login page
    Given no one is logged in
    When I access a protected page
    Then I am on the login page
    And the page contains "This is a custom login screen"

  Scenario: Customizing the logout page
    Given I am logged in as mr296
    When I log out
    Then the page contains "This is a custom logout screen"
