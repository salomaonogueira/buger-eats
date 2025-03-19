*** Settings ***
Documentation    Aqui começa tudo

Library         RequestsLibrary
Library         Collections
Library         factories/partner.py
Library         Browser

Resource       ../resources/helpers.resource
Resource       ../resources/services.resource
Resource       ../resources/rabbitmq.resource
Resource       ../pages/login.resource
Resource       ../pages/landing.resource
Resource       ../pages/signup.resource
Resource       ../pages/admin.resource


