Feature:  User

  @development
  Scenario:  Login as ole-khuntley, then logout
    Given I am ole-khuntley
    Then I login
    And I logout
