Feature: create account with data generator

  Background: 
    Given url "https://tek-insurance-api.azurewebsites.net"
    * def result = callonce read('GenerateToken.feature')
    And print result
    * def generatedToken = result.response.token
    And print generatedToken

  Scenario: Create new account using Data generator
    * def generator = Java.type('tiger.api.testForFakeData.DataGenerator')
    * def email = generator.getEmail()
    * def firstName = generator.getFirstName()
    * def LastName  = generator.getLastName()
    * def dob = generator.getDob()
    Given path "/api/accounts/add-primary-account"
    And request
      """
      {
       "email": "#(email)",
       "firstName": "#(firstName)",
       "lastName": "#(LastName)","title": "Mr.",
      "gender": "MALE",
      "maritalStatus": "MARRIED",
      "employmentStatus": "SelfEmployee",
      "dateOfBirth": "#(dob)"
       }
      """
    And header Authorization = "Bearer " + generatedToken
    When method post
    Then status 201
    And print response
    Then assert response.email ==email
    Then assert response.firstName ==firstName
