Feature: Create an account and add address to the account.

  Background: 
    Given url "https://tek-insurance-api.azurewebsites.net"
    * def createAccountResult = callonce read('CreateAccountFeature.feature')
    And print  createAccountResult
    * def primaryPersonId = createAccountResult.response.id
    * def token = createAccountResult.result.response.token

  Scenario: Add adress to an account
    Given path '/api/accounts/add-account-address'
    And param primaryPersonId =  primaryPersonId
    Given header Authorization = "Bearer " + token
    Given request
      """
      {    
      "addressType": "Home",   
      "addressLine1": "756846758 PotamicCenter",
      "city": "Woodbridge",    
      "state": "Virginia",    
      "postalCode": "22177",    
      "current": true
      }         
      """
    When method post
    Then status 201
    And print response
