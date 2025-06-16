*** Settings ***
Library           SeleniumLibrary
Library           Collections
Library           String

*** Variables ***
${RANDOM INDEX}    0

*** Keywords ***

Pick Random Product And Add To Cart
    ${shop_items}=    Get WebElements    xpath=//div[contains(@class, 'shop-item')]
    ${total}=         Get Length         ${shop_items}
    ${RANDOM INDEX}=  Evaluate           random.randint(0, ${total} - 1)    modules=random

    # Ambil dan simpan nama produk
    ${title_xpath}=   Set Variable       (//div[contains(@class,'shop-item')])[${RANDOM INDEX + 1}]//span[@class='shop-item-title']
    ${title_element}=    Get WebElement    xpath=${title_xpath}
    ${product_title}=    Get Text          ${title_element}
    Set Suite Variable   ${PRODUCT_TITLE}    ${product_title}
    Log To Console       \n>>> Produk yang dipilih: ${PRODUCT_TITLE}

    # Klik tombol ADD TO CART
    ${add_button}=       Get WebElement    xpath=(//div[contains(@class,'shop-item')])[${RANDOM INDEX + 1}]//button[contains(@class, 'shop-item-button')]
    Click Element        ${add_button}


Verify Product Added To Cart
    Wait Until Page Contains Element    xpath=//div[@class='cart-row']//span[@class='cart-item-title']
    ${cart_title_elements}=    Get WebElements    xpath=//div[@class='cart-row']//span[@class='cart-item-title']
    ${cart_titles}=    Create List
    FOR    ${element}    IN    @{cart_title_elements}
        ${cart_title}=    Get Text    ${element}
        Append To List    ${cart_titles}    ${cart_title}
    END
    ${cart_titles_str}=    Catenate    SEPARATOR=,    @{cart_titles}
    Log To Console       \n>>> Produk dalam keranjang: ${cart_titles_str}
    Should Contain    ${cart_titles_str}    ${PRODUCT_TITLE}
    Log To Console       \n>>> Produk berhasil ditambahkan ke keranjang: ${PRODUCT_TITLE}

Proceed To Checkout
    # Klik tombol CHECKOUT
    Click Element    xpath=//*[@id="prooood"]/section[1]/button
    Wait Until Page Contains Element    id=shipping-address

Filling Shipping Address
    # Isi alamat pengiriman
    Input Text    name=phone     +6282261000000
    Input Text    name=street    Sample City
    Input Text    name=city      12345
    Select From List By Label    id=countries_dropdown_menu    Indonesia

Submit Checkout
    Click Button   id=submitOrderBtn

Verify Checkout Success
    # Verifikasi halaman konfirmasi
    Wait Until Element Is Visible    id=message    10s
    ${message}=    Get Text    id=message
    Should Contain    ${message}    Congrats! Your order of
    Should Contain    ${message}    has been registered and will be shipped to