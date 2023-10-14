*** Settings ***
Resource  ..//resources/api_testing_usuario.resource

*** Variables ***

*** Test Cases ***
Cenário 01: Cadastrar um novo usuário com sucesso na ServerRest
    Criar um usuário novo
    Cadastrar o usuário criado na ServerRest
    Conferir se o usuário foi cadastrado corretamente
