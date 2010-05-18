Feature: Group authorization helpers

  Background:
    Given I am using the user interface

  Scenario: An unauthenticated user is prompted to log in for a group-permitted page
    Given no one is logged in
     When I access an owners-only page
     Then I am on the login page

  Scenario: An authenticated user in the right group can see a group-permitted page
    Given I am logged in as mr296
     When I access an owners-only page
     Then I can access that owners-only page

  Scenario: An authenticated user in the wrong group is forbidden from a group-permitted page
    Given I am logged in as zaw102
     When I access an owners-only page
     Then I am forbidden from accessing that page

  Scenario: An unauthenticated user can't see group-only content
    Given no one is logged in
     When I access the portal page
     Then I do not see the owner's content

  Scenario: An authenticated user in the right group can see group-only content
    Given I am logged in as mr296
     When I access the portal page
     Then I see the owner's content

  Scenario: An authenticated user in the wrong group can't see group-only content
    Given I am logged in as zaw102
     When I access the portal page
     Then I do not see the owner's content
