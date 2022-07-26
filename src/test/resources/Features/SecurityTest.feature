@Regression
Feature: Security test. Token Generation test

  Background: 
    Given url 'https://tek-insurance-api.azurewebsites.net/'
    And path '/api/token'

  Scenario: generate token with valid username and password.
    And request {"username": "supervisor","password": "tek_supervisor"}
    When method post
    Then status 200
    And print response

  Scenario: generate token with invalid username and password.
    And request {"username": "supervisory","password": "Jumbo.Mumbo"}
    When method post
    Then status 404
    And print response
    * def errorMessage = response.errorMessage
    And assert errorMessage == "USER_NOT_FOUND"

  Scenario: generate token with invalid password.
    And request {"username": "supervisor","password": "Jumbo.Mumbo"}
    When method post
    Then status 400
    And print response
    * def errorMessage = response.errorMessage
    And assert errorMessage == "Password Not Matched"
