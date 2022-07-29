@Regression
Feature: Generating Token with Valid/Invalid info.
Scenario: Valid username/Valid password
Given url 'https://tek-insurance-api.azurewebsites.net/'
And path '/api/token'
And request 
"""
{
  "username": "supervisor",
  "password": "tek_supervisor"
}
"""
When method post
Then status 200
And print response

Scenario: Valid Username/Invalid Password
Given url 'https://tek-insurance-api.azurewebsites.net/'
And path '/api/token'
And request 
"""
{
  "username": "OliverKahn",
  "password": "tek_supervisor"
}
"""
When method post
Then status 404
And print response