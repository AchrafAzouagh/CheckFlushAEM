*** Settings ***
Documentation                    Check Flush AEM
Library                          Selenium2Library
Library                          Collections

*** Variables ***
${BROWSER}                          Firefox
${VALID USER}                       Fennil
${VALID PASSWORD}                   mw2v8z20
*** Test Cases ***
Looping through list of urls
    ${urls}=    Create Dictionary   ITT=file:///C:/Users/aazouagh/Downloads/AEM%20Replication%20Agents%20on%20author.html
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
        #input text      username        ${VALID USER}
        #input password  password        ${VALID PASSWORD}
        #click button    submit-button
        wait until page contains     Agent
Verifying Agents
        [Arguments]     ${key}
        ${count}=   get element count   //strong[contains(text(), 'pending')]
        IF   "${count}" > "0"
            log to console  \n Il y a ${count} agent(s) en état blocked/pending sur ${key}.
            FOR     ${INDEX}    IN RANGE    ${count}
                ${status}=  run keyword and return status   element should be visible  (//strong[contains(text(), 'pending')])[${INDEX}]//ancestor::ul
                run keyword if  ${status}   capture element screenshot  (//strong[contains(text(), 'pending')])[${INDEX}]//ancestor::ul     filename= Erreur-${key}-{index}.png
            END
        END
        close browser