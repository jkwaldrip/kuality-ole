Feature:  Circulation

  Background:
    Given I have a patron

  Scenario:  Loan a resource
    Given I have an available item
    When I am a circulation user
    Then I loan the item

  Scenario:  Return a resource
    Given I have an available item
    When I am a circulation user
    And I loan the item
    Then I return the item
