*** Settings ***
Library    SeleniumLibrary

*** Variables ***
${LOGIN_URL}    https://qa-practice.netlify.app/auth_ecommerce
${EMAIL}        admin@admin.com
${PASSWORD}     admin123

*** Keywords ***
Open Browser To Login Page
    Open Browser     ${LOGINURL}    chrome
    Maximize Browser Window

Input Login Credentials
    Input Text    id=email       ${EMAIL}
    Input Text    id=password    ${PASSWORD}

Submit Form
    Click Button    id=submitLoginBtn


# Login with Valid Credentials
Login to Application
    Open Browser     ${LOGIN_URL}    chrome
    Maximize Browser Window
    Input Text    id=email       ${EMAIL}
    Input Text    id=password    ${PASSWORD}
    Click Button    id=submitLoginBtn
    Wait Until Page Contains Element    id=prooood