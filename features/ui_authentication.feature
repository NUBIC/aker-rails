Feature: Interactive authentication

  Background:
    Given I am using the user interface

  Scenario: When accessing a public page, no authentication is required
    Given no one is logged in
     When I access a public page
     Then I can access that public page

  Scenario: An unauthenticated user is prompted for credentials when accessing a protected page
    Given no one is logged in
     When I access a protected page
     Then I am on the login page

  Scenario: An authenticated user is not prompted for credentials when accessing a protected page
    Given I am logged in as mr296
     When I access a protected page
     Then I can access that protected page

  Scenario: When accessing a public page while logged in, the user is available
    Given I am logged in as mr296
     When I access a public page
     Then the page contains "Even mr296"

  Scenario: When logging out, a user sees the application's logout page
    Given I am logged in as mr296
     When I access the logout page
     Then the page contains "Good-bye, crewmate"
