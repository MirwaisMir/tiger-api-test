Feature: Security test. Verify Token test.

  Scenario: Verify valid token
    Given url "https://tek-insurance-api.azurewebsites.net"
    And path "/api/token"
    And request {"username": "supervisor", "password": "tek_supervisor"}
    When method post
    Then status 200
    * def generatedToken = response.token
    Given path "/api/token/verify"
    And param username = "supervisor"
    And param token = generatedToken
    When method get
    Then status 200
    And print response

  Scenario: Verify invalid token
    Given url "https://tek-insurance-api.azurewebsites.net"
    Given path "/api/token"
    
    And param username = "supervisor"
    And param token = "invalidtoken"
    Then status 400
    And print response
    
    
    Scenario: Verify valid token with invalid username
    Given url "https://tek-insurance-api.azurewebsites.net"
    Given path "api/token"
    And request {"username": "supervisor", "password": "tek_supervisor"}
    When method post
    And status 200
    * def generatedToken = response.token
    Given path "api/token/verify"
    And param username = "invalidUsername"
    And param token = generatedToken
    When method get
    Then status 400 
    * def errorMessage = response.errorMessage
    And assert errorMessage == "Wrong Username send along with Token"