*** Settings ***
Library           SeleniumLibrary
Resource          ../resources/login_keywords.robot
Suite Setup       Open Browser To Login Page
Suite Teardown    Close Browser

*** Test Cases ***
Login With Valid Credentials
    [Documentation]    This test case logs in with valid credentials and verifies the welcome message.
    Wait Until Page Contains Element    id=loginSection
    Input Login Credentials
    login_keywords.Submit Form
    Page Should Contain    SHOPPING CART
    #Logout after successful login
    Click Element    xpath=//a[@id="logout"]
    Wait Until Page Contains Element    id=loginSection

Login With Invalid Credentials
    [Documentation]    This test case attempts to log in with invalid credentials and verifies the error message.
    Wait Until Page Contains Element    id=loginSection
    Input Text    id=email       invalid@example.com
    Input Text    id=password    wrongpassword
    login_keywords.Submit Form
    Page Should Contain    Bad credentials! Please try again! Make sure that you've registered.


Login With Empty Credentials
    [Documentation]    This test case attempts to log in with empty credentials and verifies the error message.
    Wait Until Page Contains Element    id=loginSection
    Input Text    id=email       ${EMPTY}
    Input Text    id=password    ${EMPTY}
    login_keywords.Submit Form
    Page Should Contain    Bad credentials! Please try again! Make sure that you've registered.

Login With Missing Password
    [Documentation]    This test case attempts to log in with a missing password and verifies the error message.
    Wait Until Page Contains Element    id=loginSection
    Input Text    id=email       ${EMAIL}
    Input Text    id=password    ${EMPTY}
    login_keywords.Submit Form
    Page Should Contain    Bad credentials! Please try again! Make sure that you've registered.

Login With Missing Email
    [Documentation]    This test case attempts to log in with a missing email and verifies the error message.
    Wait Until Page Contains Element    id=loginSection
    Input Text    id=email       ${EMPTY}
    Input Text    id=password    ${PASSWORD}
    login_keywords.Submit Form
    Page Should Contain    Bad credentials! Please try again! Make sure that you've registered.

Login With Invalid Email Format
    [Documentation]    This test case attempts to log in with an invalid email format and verifies the error message.
    Wait Until Page Contains Element    id=loginSection
    Input Text    id=email       invalid-email-format
    Input Text    id=password    ${PASSWORD}
    login_keywords.Submit Form
    Page Should Contain    Bad credentials! Please try again! Make sure that you've registered.    

Login With Short Password
    [Documentation]    This test case attempts to log in with a short password and verifies the error message.
    Wait Until Page Contains Element    id=loginSection
    Input Text    id=email       ${EMAIL}
    Input Text    id=password    short
    login_keywords.Submit Form
    Page Should Contain    Bad credentials! Please try again! Make sure that you've registered.

Login With Long Password    
    [Documentation]    This test case attempts to log in with a long password and verifies the error message.
    Wait Until Page Contains Element    id=loginSection
    Input Text    id=email       ${EMAIL}
    Input Text    id=password    thisisaverylongpasswordthatshouldnotbeaccepted
    login_keywords.Submit Form
    Page Should Contain    Bad credentials! Please try again! Make sure that you've registered.

Login With SQL Injection Attempt
    [Documentation]    This test case attempts to log in with an SQL injection string and verifies the error message.
    Wait Until Page Contains Element    id=loginSection
    Input Text    id=email       ${EMAIL}
    Input Text    id=password    ' OR '1'='1
    login_keywords.Submit Form
    Page Should Contain    Bad credentials! Please try again! Make sure that you've registered.

Login With XSS Attempt
    [Documentation]    This test case attempts to log in with an XSS attack string and verifies the error message.
    Wait Until Page Contains Element    id=loginSection
    Input Text    id=email       ${EMAIL}
    Input Text    id=password    <script>alert('XSS')</script>
    login_keywords.Submit Form
    Page Should Contain    Bad credentials! Please try again! Make sure that you've registered.
