Feature: Remote activity
  As a performance tester
  I want to be able to load testing modules
  In order to stresstest my application

  Scenario: Execute activity
    Given I have a remote activity
    When I execute the activity
    Then The run statements should be executed
