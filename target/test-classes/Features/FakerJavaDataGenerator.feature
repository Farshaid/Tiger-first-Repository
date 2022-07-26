@test @Regression
Feature: Generate CSR portal Token

  Background: 
    Given url 'https://tek-insurance-api.azurewebsites.net/'
    * def result = callonce read('GenerateToken.feature')
    And print result
    * def generatedToken = result.response.token
    And print generatedToken

  Scenario: Create new account using Data Generator;
    * def generator = Java.type('tiger.api.test.data.DataGenerator')
    * def email = generator.getEmail()
    * def firstName = generator.getFirstName()
    * def lastName = generator.getLastName()
    * def DOB = generator.getDoB()
    * def Job = generator.getJob()
    Given path '/api/accounts/add-primary-account'
    And request
      """
      {
      "email": "#(email)",
      "title": "Mr",
      "firstName": "#(firstName)",
      "lastName": "#(lastName)",
      "gender": "MALE",
      "maritalStatus": "MARRIED",
      "employmentStatus": "#(Job)",
      "dateOfBirth": "#(DOB)"
      }
      """
    And header Authorization = "Bearer " + generatedToken
    When method post
    Then status 201
    * def generatedId = response.id
    And print response
    Then assert response.email == email
    And print response

