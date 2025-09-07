@book_store
Feature: Post method to book store

  Background:
    * def header = read('classpath:br/com/vale/support/config/headers.yaml')
    * def email = Java.type('br.com.vale.support.utils.Utils').generateEmail()
    * def password = Java.type('br.com.vale.support.utils.Utils').password()
    * def name = Java.type('br.com.vale.support.utils.Utils').generateNewName()

  @list_book
  Scenario Outline: List book
    Given url url
    And  path '/BookStore/v1/Books',
    When method Get
    Then status <status_code>
    And  match response == '#object'
    * string jsonSchemaExpected = read('classpath:br/com/vale/features/bookStore/data/response/' + env + '/listBook.json')
    * string jsonData = response
    * def SchemaUtils = Java.type('br.com.vale.support.utils.JSONSchemaUtil')
    * assert SchemaUtils.isValid(jsonData, jsonSchemaExpected)
    * print response

    Examples:
      |status_code |
      |       200  |

    @reserve_book
  Scenario Outline: Reserv book
    * def body = read('classpath:br/com/vale/features/bookStore/data/payload/' + env + '/reserv.json')
    * def resp = read('classpath:br/com/vale/features/bookStore/data/response/' + env + '/reserv.json')

    Given url url
    And  path '/BookStore/v1/Books'
    And headers {accept: 'application/json', Authorization: 'Basic VkFMRTpUZXN0MUA1NDQyNw=='}
    And request body
    When method Post
    Then status <status_code>
    And match response == resp
    * print response

    Examples:
      |status_code |
      |       201  |


