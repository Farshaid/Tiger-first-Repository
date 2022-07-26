@AccountWithAddress @Regression
Feature: Create account with Data generator

  #We are going to re-use a generate token feature.
  # Re-usablility of feature file.
  Background: Prepare for test. generate token. generate new Primary Account.
    Given url 'https://tek-insurance-api.azurewebsites.net/'
    * def result = callonce read('GenerateToken.feature')
    And print result
    * def generatedToken = result.response.token
    And print generatedToken	
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

  Scenario: Add address to already exisiting account using Faker.
    * def generator = Java.type('tiger.api.test.data.DataGenerator')
    * def country = generator.getCountry()
    * def city = generator.getCity()
    * def zipCode = generator.getZipCode()
    * def state = generator.getState()
    * def street = generator.getStreetAdd()
    * def CountryCode = generator.getCountryCode()
    Given path '/api/accounts/add-account-address'
    And param primaryPersonId = generatedId
    And request
      """
      {
      "addressType": "Home",
      "addressLine1": "#(street)",
      "city": "#(city)",
      "state": "#(state)",
      "postalCode": "#(zipCode)",
      "countryCode": "#(CountryCode)",
      "current": true
      }
      """
    And header Authorization = "Bearer " + generatedToken
    When method post
    Then status 201
    And print response
