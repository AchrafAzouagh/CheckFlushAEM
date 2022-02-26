*** Settings ***
Documentation                    Check Flush AEM
Library                          Selenium2Library
Library                          Collections

*** Variables ***
${BROWSER}                          Firefox
${VALID USER}                       Fennil
${VALID PASSWORD}                   mw2v8z20
#${INDEX}                            1
*** Test Cases ***
Test Check Flush AEM
    ${urls}=    Create Dictionary   ITT=http://aem-author-64-itt-private1.aws.dmpa-noprod.myengie.com:4502/libs/granite/core/content/login.html?resource=%2Fetc%2Freplication%2Fagents.author.html&$$login$$=%24%24login%24%24&j_reason=unknown&j_reason_code=unknown   INT=http://aem-author-64-int-private1.aws.dmpa-noprod.myengie.com:4502/libs/granite/core/content/login.html?resource=%2Fetc%2Freplication%2Fagents.author.html&$$login$$=%24%24login%24%24&j_reason=unknown&j_reason_code=unknown   ACC=http://aem-author-64-acc-private1.aws.dmpa-noprod.myengie.com:4502/libs/granite/core/content/login.html?resource=%2Fetc%2Freplication%2Fagents.author.html&$$login$$=%24%24login%24%24&j_reason=unknown&j_reason_code=unknown   PreProd=http://aem-author-64-preprod-private1.aws.dmpa-noprod.myengie.com:4502/libs/granite/core/content/login.html?resource=%2Fetc%2Freplication%2Fagents.author.html&$$login$$=%24%24login%24%24&j_reason=unknown&j_reason_code=unknown   Prod=http://aem-author-64-prod-private1.aws.dmpa.myengie.com:4502/libs/granite/core/content/login.html?resource=%2Fetc%2Freplication%2Fagents.author.html&$$login$$=%24%24login%24%24&j_reason=unknown&j_reason_code=unknown
    FOR     ${key}  IN  @{urls.keys()}
    Opening Browser     ${urls["${key}"]}
    Authenticating
    Verifying Agents    ${key}
    END
*** Keywords ***
Opening Browser
        [Arguments]   ${key}
        open browser    ${key}    ${BROWSER}
        maximize browser window
Authenticating
        input text      username        ${VALID USER}
        input password  password        ${VALID PASSWORD}
        click button    submit-button
        wait until page contains     Agent
Verifying Agents
        [Arguments]     ${key}
        ${count}=   get element count   //strong[contains(text(), 'pending')]
        IF   "${count}" > "0"
            log to console  \n Il y a ${count} agent(s) en état blocked/pending sur ${key}.
            FOR     ${INDEX}    IN RANGE    ${count}
                scroll element into view    (//strong[contains(text(), 'pending')])[${INDEX+1}]
                ${status}=  run keyword and return status   element should be visible  (//strong[contains(text(), 'pending')])[${INDEX+1}]
                run keyword if  ${status}   capture page screenshot     filename= ErreurSolution-${key}-${INDEX}.png
            END
        END
        close browser