@Smoke @Regression
Feature: Security test. Verify Token test.

  Scenario: Verify valid token.
    Given url 'https://tek-insurance-api.azurewebsites.net/'
    And path '/api/token'
    And request {"username": "supervisor","password": "tek_supervisor"}
    When method post
    Then status 200
    * def generatedToken = response.token
    Given path '/api/token/verify'
    And param username = 'supervisor'
    And param token = generatedToken
    When method get
    Then status 200
    And print response

  # 3) test api endpoint "/api/token/verify" with invalid token.
  # Note: since it's invalid token it can be any random string. you don't need to generate a new token
  # Status should be 400 – bad request and response should be TOKEN_EXPIRED
  Scenario: Verify invalid token.
    Given url 'https://tek-insurance-api.azurewebsites.net/'
    Given path '/api/token/verify'
    And param username = 'supervisor'
    And param token = 'how is the weather'
    When method get
    Then status 400
    * def errorMessage = response.errorMessage
    And assert errorMessage == "Token Expired or Invalid Token"
    And print response
	@NegativeSecurity
  Scenario: Verify token, wrong username, right token
    Given url 'https://tek-insurance-api.azurewebsites.net/'
    And path '/api/token'
    And request {"username": "supervisor","password": "tek_supervisor"}
    When method post
    Then status 200
    * def generatedToken = response.token
    Given path '/api/token/verify'
    And param username = 'BarakObama'
    And param token = generatedToken
    When method get
    Then status 400
    And print response
    * def errorMsg = response.errorMessage
    And assert errorMsg == "Wrong Username send along with Token"
