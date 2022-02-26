*** Settings ***
Documentation                    This is a basic test
Library                          Selenium2Library

*** Variables ***
${BROWSER}                          Firefox
${VALID USER}                       Fennil
${VALID PASSWORD}                   mw2v8z20
${LOGIN URL}                        http://aem-author-64-itt-private1.aws.dmpa-noprod.myengie.com:4502/libs/granite/core/content/login.html?resource=%2Fetc%2Freplication%2Fagents.author.html&$$login$$=%24%24login%24%24&j_reason=unknown&j_reason_code=unknown
${ELEMENTS}
${test}                             43
#${source}=    Page Source
#${matches}=   Get Regexp Matches    ${source}   >.*\b(pending)\b.*<

*** Test Cases ***
Example
    run keyword if  "${test}" == "42"
        ...     log to console   the result is 42
        ...     ELSE
        ...     log to console   the result is not 42
Open Browser To Login Page
    open browser    ${LOGIN URL}    ${BROWSER}
    maximize browser window

Login Page Should Be Open
    wait until page contains        Se connecter

Input Username
    input text      username        ${VALID USER}

input password
    input password  password        ${VALID PASSWORD}

Submit Credentials
    click button    submit-button

Getting Pending number of occurences
    Wait Until Page Contains    Agent
    #${count}=     Get Length    ${matches}
    #log to console  ${count}
    //li[text()='pending']
    ${test2}=  Get Matching Xpath Count  //*[contains(., "pending")]
    ${count}    get element count  count  ${//*[contains(., "pending")]}
Getting Source Code
    get source
Close browser
    close browser
*** Keywords ***
