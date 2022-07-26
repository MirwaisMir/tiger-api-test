Feature: New Assignment

  Background: 
    Given url "https://tek-insurance-api.azurewebsites.net"
    Given path "/api/token"
    And request {"username": "supervisor","password": "tek_supervisor"}
    When method post
    Then status 200
    * def generatedToken = response.token
#
  #Scenario: Create an account
    #Given path"/api/accounts/add-primary-account"
    #And request{"id": 0, "email": "Mirwais.Mir1@gmail.com","firstName": "Mirwais","lastName": "Mir","title": "Mr.","gender": "MALE","maritalStatus": "MARRIED","employmentStatus": "Self-Employee","dateOfBirth": "1988-07-23T21:09:32.057Z","new": true}
    #And header Authorization = {"Bearer "}+generatedToken
    #When method post
    #Then status 201
    #And print response

  Scenario: Add address to existing Email address.
    Given path "/api/accounts/add-primary-account"
    And request{"id": 0, "email": "Mirwais.Mir1@gmail.com","firstName": "Mirwais","lastName": "Mir","title": "Mr.","gender": "MALE","maritalStatus": "MARRIED","employmentStatus": "Self-employee","dateOfBirth": "1988-07-23T21:09:32.057Z","new": true}
    And header Authorization = {"Bearer "}+generatedToken
    When method post
    Then status 400
    * def errorCode = response.errorCode
    * def httpStatus = response.httpStatus
    And print response

  Scenario: Add car to car to existing account.
    Given path "/api/accounts/add-account-car"
    And request {"id": 0,"make": "Toyota","model": "Highlander","year": "2022","licensePlate": "Vip222"}
    Given header Authorization = "Bearer " + generatedToken
    When method post
    Then status 201
    And print response

  Scenario: Add Phone number to existing account.
    Given path "/api/accounts/add-account-phone"
    And request {"id": 0,"phoneNumber": "6785423223","phoneExtension": "4567894323","phoneTime": "Evening","phoneType": "Iphone"}
    Given header Authorization = "Bearer " + generatedToken
    When method post
    Then status 201
    And print response
