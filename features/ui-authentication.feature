Feature: Interactive authentication

  Scenario: When accessing a public page, no authentication is required
    Given no one is logged in
     When I access a public page
     Then I can access that public page

  @wip
  Scenario: An unauthenticated user is prompted for credentials when accessing a protected page
    Given no one is logged in
     When I access a protected page
     Then I am on the login page

  @wip
  Scenario: An authenticated user is not prompted for credentials when accessing a protected page
    Given I am logged in as mr296
     When I access a protected page
     Then I can access that protected page
