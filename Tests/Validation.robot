*** Settings ***
Documentation                    Check Flush AEM
Library                          Selenium2Library
Library                          Collections

*** Variables ***
${BROWSER}                          Firefox
${VALID USER}                       Fennil
${VALID PASSWORD}                   mw2v8z20
*** Test Cases ***
Creating Dictionnary
    Looping through list of urls
*** Keywords ***
Looping through list of urls
    #${urls}=    Create Dictionary   ITT=http://aem-author-64-itt-private1.aws.dmpa-noprod.myengie.com:4502/libs/granite/core/content/login.html?resource=%2Fetc%2Freplication%2Fagents.author.html&$$login$$=%24%24login%24%24&j_reason=unknown&j_reason_code=unknown   INT=http://aem-author-64-int-private1.aws.dmpa-noprod.myengie.com:4502/libs/granite/core/content/login.html?resource=%2Fetc%2Freplication%2Fagents.author.html&$$login$$=%24%24login%24%24&j_reason=unknown&j_reason_code=unknown   ACC=http://aem-author-64-acc-private1.aws.dmpa-noprod.myengie.com:4502/libs/granite/core/content/login.html?resource=%2Fetc%2Freplication%2Fagents.author.html&$$login$$=%24%24login%24%24&j_reason=unknown&j_reason_code=unknown   PreProd=http://aem-author-64-preprod-private1.aws.dmpa-noprod.myengie.com:4502/libs/granite/core/content/login.html?resource=%2Fetc%2Freplication%2Fagents.author.html&$$login$$=%24%24login%24%24&j_reason=unknown&j_reason_code=unknown   Prod=http://aem-author-64-prod-private1.aws.dmpa.myengie.com:4502/libs/granite/core/content/login.html?resource=%2Fetc%2Freplication%2Fagents.author.html&$$login$$=%24%24login%24%24&j_reason=unknown&j_reason_code=unknown
    ${urls}=    Create Dictionary   ITT=file:///C:/Users/aazouagh/Downloads/AEM%20Replication%20Agents%20on%20author.html
    FOR    ${key}    IN    @{urls.keys()}
        open browser    ${urls["${key}"]}    ${BROWSER}
        maximize browser window
        #input text      username        ${VALID USER}
        #input password  password        ${VALID PASSWORD}
        #click button    submit-button
        wait until page contains     Agent
        ${count}=   get element count   //strong[contains(text(), 'pending')]
        IF   "${count}" > "0"
            log to console  \n Il y a ${count} agent(s) en état blocked/pending sur ${key}.
            FOR     ${INDEX}    IN RANGE    ${count}
                ${status}=  run keyword and return status   element should be visible  (//strong[contains(text(), 'pending')])[${INDEX}]
                run keyword if  ${status}   capture element screenshot  (//strong[contains(text(), 'pending')])[${INDEX}]//ancestor::ul   filename= ScreenshotPending-{index}.png
            END
        END
        close browser
    END