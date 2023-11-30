Feature: Testando a API ReqRes

Background:
  * def url_base = 'https://reqres.in/api'

Scenario: Pegando lista de usuários
  Given url url_base
  And path 'users'
  When method get
  Then status 200
  And match $.data[*].id != null

Scenario: Criando novo usuário
  Given url url_base
  And path 'users'
  And request { "name": "John", "job": "Tester" }
  When method post
  Then status 201
  And match $.id != null

Scenario: Criando uma nova conta com dados faltando
  Given url url_base
  And path 'register'
  And request { "email": "teste@teste.com" } 
  When method post
  Then status 400

Scenario:Pegando dados de um usuário específico
  Given url url_base
  And path 'users/2'
  When method get
  Then status 200
  And match $.data.id == 2

Scenario: Pegando dados de um usuário inexistente
  Given url url_base
  And path 'users/999'  
  When method get
  Then status 404

Scenario: Atualizando dados de um usuário
  Given url url_base
  And path 'users/2'
  And request { "name": "UpdatedName", "job": "UpdatedJob" }
  When method put
  Then status 200
  And match $.name == "UpdatedName"
