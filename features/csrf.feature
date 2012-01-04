Feature: Rails CSRF interaction
  Background:
    Given I am using the user interface
    And I am logged in as mr296

  Scenario: CSRF attacks are not processed
    When I access a protected page without a CSRF token
    Then I am on the login page

  Scenario: Requests with a CSRF token are processed
    When I access a protected page with a correct CSRF token
    Then I can access that protected page
