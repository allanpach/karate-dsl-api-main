@account_user
Feature: Post method to creat users

  Background:
    * def header = read('classpath:br/com/vale/support/config/headers.yaml')
    * def email = Java.type('br.com.vale.support.utils.Utils').generateEmail()
    * def password = Java.type('br.com.vale.support.utils.Utils').password()
    * def name = Java.type('br.com.vale.support.utils.Utils').generateNewName()

  @create_user
  Scenario Outline: Create user
    * def body = read('classpath:br/com/vale/features/account/data/payload/' + env + '/register.json')
    * def resp = read('classpath:br/com/vale/features/account/data/response/' + env + '/user.json')

    Given url url
    And  path '/Account/v1/User',
    And request body
    When method Post
    Then status <status_code>
    And match response == resp
    * print response

    Examples:
      |status_code |
      |       201  |

  @create_token
  Scenario Outline: Create token
    * def body = read('classpath:br/com/vale/features/account/data/payload/' + env + '/login.json')
    * def resp = read('classpath:br/com/vale/features/account/data/response/' + env + '/token.json')

    Given url url
    And  path '/Account/v1/GenerateToken',
    And request body
    When method Post
    Then status <status_code>
    And match response == resp
    * print response

    Examples:
      |status_code |
      |       200  |

  @authorized
  Scenario Outline: Authorized

    * def body = read('classpath:br/com/vale/features/account/data/payload/' + env + '/login.json')
    * def resp = read('classpath:br/com/vale/features/account/data/response/' + env + '/false.json')

    Given url url
    And  path '/Account/v1/Authorized',
    And request body
    When method Post
    Then status <status_code>
    And match response == resp
    * print response

    Examples:
      |status_code |
      |       200  |

  @detail_reserve
  Scenario Outline: Detail reserv book
    Given url url
    And  path '/Account/v1/User/945f0552-32c3-4d70-a745-56cd319555af'
    And headers {accept: 'application/json', Authorization: 'Basic VkFMRTpUZXN0MUA1NDQyNw=='}
    When method Get
    Then status <status_code>
    And  match response == '#object'
    * string jsonSchemaExpected = read('classpath:br/com/vale/features/account/data/response/' + env + '/reservlistBook.json')
    * string jsonData = response
    * def SchemaUtils = Java.type('br.com.vale.support.utils.JSONSchemaUtil')
    * assert SchemaUtils.isValid(jsonData, jsonSchemaExpected)
    * print response

    Examples:
      |status_code |
      |       200  |