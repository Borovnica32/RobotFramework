# Block for defining libraries
*** Settings ***
Library    SeleniumLibrary
Resource    funkcije.robot

*** Variables ***
${browser}        edge
${glavnaStran}    http://saturnmerkur.ddns.net/zverina/internacionala

*** Test Cases ***
Log in User and then Log out
    Open Browser    ${glavnaStran}    ${browser}    
    Maximize Browser Window
    Log In User
    Log Out User 


