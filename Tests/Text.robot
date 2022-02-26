*** Settings ***
Documentation                    This is a basic test
Library                          Selenium2Library
Library                          Collections

*** Variables ***
${BROWSER}                          Firefox
${VALID USER}                       Fennil
${VALID PASSWORD}                   mw2v8z20

*** Test Cases ***
Creating List of Urls
    @{MyList} =    Create List
        Append To List    ${MyList}    http://aem-author-64-itt-private1.aws.dmpa-noprod.myengie.com:4502/libs/granite/core/content/login.html?resource=%2Fetc%2Freplication%2Fagents.author.html&$$login$$=%24%24login%24%24&j_reason=unknown&j_reason_code=unknown
        Append To List    ${MyList}    http://aem-author-64-int-private1.aws.dmpa-noprod.myengie.com:4502/libs/granite/core/content/login.html?resource=%2Fetc%2Freplication%2Fagents.author.html&$$login$$=%24%24login%24%24&j_reason=unknown&j_reason_code=unknown
        Append To List    ${MyList}    http://aem-author-64-acc-private1.aws.dmpa-noprod.myengie.com:4502/libs/granite/core/content/login.html?resource=%2Fetc%2Freplication%2Fagents.author.html&$$login$$=%24%24login%24%24&j_reason=unknown&j_reason_code=unknown
        Append To List    ${MyList}    http://aem-author-64-preprod-private1.aws.dmpa-noprod.myengie.com:4502/libs/granite/core/content/login.html?resource=%2Fetc%2Freplication%2Fagents.author.html&$$login$$=%24%24login%24%24&j_reason=unknown&j_reason_code=unknown
        Append To List    ${MyList}    http://aem-author-64-prod-private1.aws.dmpa.myengie.com:4502/libs/granite/core/content/login.html?resource=%2Fetc%2Freplication%2Fagents.author.html&$$login$$=%24%24login%24%24&j_reason=unknown&j_reason_code=unknown
    FOR    ${url}    IN    @{MyList}
       open browser    ${url}    ${BROWSER}
       maximize browser window
       input text      username        ${VALID USER}
       input password  password        ${VALID PASSWORD}
       click button    submit-button
       wait until page contains        Agent

       ${count}=   get element count   //strong[contains(text(), 'pending')]
       log to console  ${count}
       close browser
    END
*** Keywords ***
