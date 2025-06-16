*** Settings ***
Library           SeleniumLibrary
Resource          ../resources/checkout_keywords.robot
Resource          ../resources/login_keywords.robot
Suite Setup       Login to Application
Suite Teardown    Close Browser

*** Test Cases ***
Checkout With Random Product
    [Documentation]    This test case adds a random product to the cart and proceeds to checkout.
    Pick Random Product And Add To Cart
    Verify Product Added To Cart
    Proceed To Checkout
    Filling Shipping Address
    Submit Checkout
    Verify Checkout Success