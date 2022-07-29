@Regression
Feature: Create Account
Background: 
Given url 'https://tek-insurance-api.azurewebsites.net/'
And path '/api/token'
And request {"username": "supervisor","password": "tek_supervisor"}
When method post
Then status 200
	* def generatedToken = response.token
	
Scenario: Create new Account happy path
Given path '/api/accounts/add-primary-account'
And request {"email": "Barak.Omama1212@Gmail.com","title": "Mr","firstName": "Barak","lastName": "Obama","gender": "MALE","maritalStatus": "MARRIED","employmentStatus": "EX-President","dateOfBirth": "1973-08-17"}
And header Authorization = "Bearer " + generatedToken
When method post
Then status 201
And print response

Scenario: Create account with an exisiting email Address
Given path '/api/accounts/add-primary-account'
And request {"email": "Barak.Obama@Gmail.com","title": "Mr","firstName": "Barak","lastName": "Obama","gender": "MALE","maritalStatus": "MARRIED","employmentStatus": "EX-President","dateOfBirth": "1973-08-17"}
And header Authorization = "Bearer " + generatedToken
When method post
Then status 400
And print response
	* def errorMsg = response.errorMessage
	And assert errorMsg == 'Account with Email Barak.Obama@Gmail.com is exist'
