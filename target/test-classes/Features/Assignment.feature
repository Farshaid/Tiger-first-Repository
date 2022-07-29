# 2)Test API endpoint "/api/accounts/add-primary-account" to add new Account with Existing email address.
      # Then status code should be 400 � Bad Request ,  validate response
       
        # 3)Test API endpoint "/api/accounts/add-account-car" to add car to existing account.
      # Then status code should be 201 � Create ,  validate response
       
        # 4)Test API endpoint "/api/accounts/add-account-phone" to add Phone number to existing account.
      # Then status code should be 201 � Create ,  validate response
       
        # 5)Test API endpoint "/api/accounts/add-account-address" to add address to existing account.
      # Then status code should be 201 � Create ,  validate response
  @Regression    
Feature: Assignment:Create Account, add Phone Number, add address, add Car to exisitng email Address.
Background: 
Given url 'https://tek-insurance-api.azurewebsites.net/'
And path '/api/token'
And request {"username": "supervisor","password": "tek_supervisor"}
When method post
Then status 200
	* def generatedToken = response.token

Scenario: Create account with an exisiting email Address
Given path '/api/accounts/add-primary-account'
And request {"email": "Barak.Obama@Gmail.com","title": "Mr","firstName": "Barak","lastName": "Obama","gender": "MALE","maritalStatus": "MARRIED","employmentStatus": "EX-President","dateOfBirth": "1973-08-17"}
And header Authorization = "Bearer " + generatedToken
When method post
Then status 400
And print response
	* def errorMsg = response.errorMessage
	And assert errorMsg == 'Account with Email Barak.Obama@Gmail.com is exist'
	
Scenario: Add Phone Number to Exisiting account.
Given path '/api/accounts/add-account-phone'
And param primaryPersonId = '43'
And request {"phoneNumber": "7527121345","phoneExtension": "002","phoneTime": "Evening","phoneType": "Work"}
And header Authorization = 'Bearer ' + generatedToken
When method post
Then status 201
And print response 

Scenario: Add Address to existing account (Email Address) 
Given path 	"/api/accounts/add-account-address" 
And param primaryPersonId = '43'
And request {"addressType": "Home","addressLine1": "1233 SilverLine square","city": "Washington","state": "DC","postalCode": "20011","countryCode": "1","current": "true"}
And header Authorization = 'Bearer ' + generatedToken
When method post 
Then status 201
And print response	      
	      

Scenario: Add Car to existing account 
Given path 	"/api/accounts/add-account-car" 
And param primaryPersonId = '43'
And request {"make": "Toyota","model": "Lexus","year": "2022","licensePlate": "VA-007"}
And header Authorization = 'Bearer ' + generatedToken
When method post 
Then status 201
And print response	      