Feature: Create Account

  Background: generate token for all scenarios
    Given url "https://tek-insurance-api.azurewebsites.net"
    And path "api/token"
    * def result = callonce read('GenerateToken.feature')
    * def generatedToken = result.response.token
    And header Authorization = "Bearer " + generatedToken

  Scenario: Create new Account happy path
    Given path "api/accounts/add-primary-account"
    And request {"id": 0, "email": "Mirjan1.Mir@gmail.com","title": "Mr.","firstName": "MirJan","lastName": "Mirkhan","gender": "MALE","maritalStatus": "SINGLE","employmentStatus": "QA enginner","dateOfBirth": "11/11/1988"}
    When method post
    Then status 201
    And print response
