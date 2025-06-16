*** Settings ***
Library    SeleniumLibrary

*** Variables ***
${LOGIN_URL}    https://qa-practice.netlify.app/auth_ecommerce
${EMAIL}        admin@admin.com
${PASSWORD}     admin123

*** Keywords ***
Open Browser To Login Page
    ${options}=    Evaluate    sys.modules['selenium.webdriver'].ChromeOptions()    sys, selenium.webdriver
    Call Method    ${options}    add_argument    --headless
    Call Method    ${options}    add_argument    --no-sandbox
    Call Method    ${options}    add_argument    --disable-dev-shm-usage
    Create WebDriver    Chrome    options=${options}
    Go To    ${LOGIN_URL}
    Maximize Browser Window

Input Login Credentials
    Input Text    id=email       ${EMAIL}
    Input Text    id=password    ${PASSWORD}

Submit Form
    Click Button    id=submitLoginBtn

Login to Application
    Open Browser To Login Page
    Input Login Credentials
    Submit Form
    Wait Until Page Contains Element    id=prooood