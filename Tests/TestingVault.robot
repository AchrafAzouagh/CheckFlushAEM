*** Settings ***
Documentation                    This is a basic test
Library                          Selenium2Library
Library                          Collections
*** Variables ***
${BROWSER}                          Firefox
${VALID USER}                       Fennil
${VALID PASSWORD}                   mw2v8z20
@{MyList}   http://aem-author-64-itt-private1.aws.dmpa-noprod.myengie.com:4502/libs/granite/core/content/login.html?resource=%2Fetc%2Freplication%2Fagents.author.html&$$login$$=%24%24login%24%24&j_reason=unknown&j_reason_code=unknown   http://aem-author-64-int-private1.aws.dmpa-noprod.myengie.com:4502/libs/granite/core/content/login.html?resource=%2Fetc%2Freplication%2Fagents.author.html&$$login$$=%24%24login%24%24&j_reason=unknown&j_reason_code=unknown   http://aem-author-64-acc-private1.aws.dmpa-noprod.myengie.com:4502/libs/granite/core/content/login.html?resource=%2Fetc%2Freplication%2Fagents.author.html&$$login$$=%24%24login%24%24&j_reason=unknown&j_reason_code=unknown   http://aem-author-64-preprod-private1.aws.dmpa-noprod.myengie.com:4502/libs/granite/core/content/login.html?resource=%2Fetc%2Freplication%2Fagents.author.html&$$login$$=%24%24login%24%24&j_reason=unknown&j_reason_code=unknown   http://aem-author-64-prod-private1.aws.dmpa.myengie.com:4502/libs/granite/core/content/login.html?resource=%2Fetc%2Freplication%2Fagents.author.html&$$login$$=%24%24login%24%24&j_reason=unknown&j_reason_code=unknown
*** Test Cases ***
Checking List of Urls
    FOR    ${url}    IN    @{MyList}
       open browser    ${url}    ${BROWSER}
       maximize browser window
       input text      username        ${VALID USER}
       input password  password        ${VALID PASSWORD}
       click button    submit-button
       wait until page contains     Agent
       ${count}=   get element count   //strong[contains(text(), 'pending')]
        IF   "${count}" > "0"
            log to console  \n Il y a ${count} agent(s) en état blocked/pending.
       END
       close browser
    END

*** Keywords ***
#            FOR ${i}    IN RANGE    ${count}
#               capture element screenshot  //h2[contains(@class, 'cq-agent-header-on')]
               #capture element screenshot  //div[contains(@class, 'li-bullet cq-agent-queue-blocked')]
               #scroll element into view     pending
#            END
#       close browser