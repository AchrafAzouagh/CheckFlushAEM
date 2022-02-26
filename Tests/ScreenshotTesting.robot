*** Settings ***
Documentation                    This is a basic test
Library                          Selenium2Library
Library                          Collections
*** Variables ***
${BROWSER}                          Firefox
${VALID USER}                       Fennil
${VALID PASSWORD}                   mw2v8z20

#@{MyList}   http://aem-author-64-itt-private1.aws.dmpa-noprod.myengie.com:4502/libs/granite/core/content/login.html?resource=%2Fetc%2Freplication%2Fagents.author.html&$$login$$=%24%24login%24%24&j_reason=unknown&j_reason_code=unknown   http://aem-author-64-int-private1.aws.dmpa-noprod.myengie.com:4502/libs/granite/core/content/login.html?resource=%2Fetc%2Freplication%2Fagents.author.html&$$login$$=%24%24login%24%24&j_reason=unknown&j_reason_code=unknown   http://aem-author-64-acc-private1.aws.dmpa-noprod.myengie.com:4502/libs/granite/core/content/login.html?resource=%2Fetc%2Freplication%2Fagents.author.html&$$login$$=%24%24login%24%24&j_reason=unknown&j_reason_code=unknown   http://aem-author-64-preprod-private1.aws.dmpa-noprod.myengie.com:4502/libs/granite/core/content/login.html?resource=%2Fetc%2Freplication%2Fagents.author.html&$$login$$=%24%24login%24%24&j_reason=unknown&j_reason_code=unknown   http://aem-author-64-prod-private1.aws.dmpa.myengie.com:4502/libs/granite/core/content/login.html?resource=%2Fetc%2Freplication%2Fagents.author.html&$$login$$=%24%24login%24%24&j_reason=unknown&j_reason_code=unknown
*** Test Cases ***
Checking List of Urls
    ${urls}=    Create Dictionary   A=file:///C:/Users/aazouagh/Downloads/AEM%20Replication%20Agents%20on%20author.html
    FOR    ${key}    IN    @{urls.keys()}
       open browser    ${urls["${key}"]}    ${BROWSER}
       maximize browser window
       wait until page contains     Agent
       ${status}=   run keyword and return status  wait until page contains    pending
       RUN KEYWORD IF   ${status}    capture page screenshot    filename= achraf-{index}.png
       Execute JavaScript    window.scrollTo(0, 2500)
       sleep    5s
       ${status}=   run keyword and return status   wait until page contains    pending
       RUN KEYWORD IF   ${status}    capture page screenshot    filename= achraf-{index}.png
       sleep    5s
       close browser
    END

*** Keywords ***
#            FOR ${i}    IN RANGE    ${count}
#               capture element screenshot  //h2[contains(@class, 'cq-agent-header-on')]
               #capture element screenshot  //div[contains(@class, 'li-bullet cq-agent-queue-blocked')]
               #scroll element into view     pending
#            END
#       close browser