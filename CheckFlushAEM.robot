*** Settings ***
Documentation                    Check Flush AEM
Library                          Selenium2Library
Library                          Collections
Library           RPA.Email.ImapSmtp    smtp_server=smtp.gmail.com    smtp_port=587
*** Variables ***
${BROWSER}                          Firefox     #à changer
${VALID USER}                       Fennil
${VALID PASSWORD}                   mw2v8z20
${USERNAME}       adresse mail                  #à changer
${PASSWORD}       password                      #à changer
${RECIPIENT}      destinataire                  #à changer

*** Test Cases ***
Check Flush AEM
    ${urls}=    Create Dictionary   ITT=http://aem-author-64-itt-private1.aws.dmpa-noprod.myengie.com:4502/libs/granite/core/content/login.html?resource=%2Fetc%2Freplication%2Fagents.author.html&$$login$$=%24%24login%24%24&j_reason=unknown&j_reason_code=unknown   INT=http://aem-author-64-int-private1.aws.dmpa-noprod.myengie.com:4502/libs/granite/core/content/login.html?resource=%2Fetc%2Freplication%2Fagents.author.html&$$login$$=%24%24login%24%24&j_reason=unknown&j_reason_code=unknown   ACC=http://aem-author-64-acc-private1.aws.dmpa-noprod.myengie.com:4502/libs/granite/core/content/login.html?resource=%2Fetc%2Freplication%2Fagents.author.html&$$login$$=%24%24login%24%24&j_reason=unknown&j_reason_code=unknown   PreProd=http://aem-author-64-preprod-private1.aws.dmpa-noprod.myengie.com:4502/libs/granite/core/content/login.html?resource=%2Fetc%2Freplication%2Fagents.author.html&$$login$$=%24%24login%24%24&j_reason=unknown&j_reason_code=unknown   Prod=http://aem-author-64-prod-private1.aws.dmpa.myengie.com:4502/libs/granite/core/content/login.html?resource=%2Fetc%2Freplication%2Fagents.author.html&$$login$$=%24%24login%24%24&j_reason=unknown&j_reason_code=unknown
    FOR     ${key}  IN  @{urls.keys()}

    Opening Browser     ${urls["${key}"]}
    Authenticating
    Verifying Agents    ${key}

    END
*** Keywords ***
Opening Browser
        [Documentation]  Opening Browser...
        [Arguments]   ${key}
        open browser    ${key}    ${BROWSER}
        maximize browser window
Authenticating
        [Documentation]  Authenticating...
        input text      username        ${VALID USER}
        input password  password        ${VALID PASSWORD}
        click button    submit-button
        wait until page contains     Agent
Verifying Agents
        [Documentation]  Verifying Agents...
        [Arguments]     ${key}
        ${count}=   get element count   //strong[contains(text(), 'pending')]
        IF   "${count}" > "0"
            log to console  \n Il y a ${count} agent(s) en état blocked/pending sur ${key}.
            FOR     ${INDEX}    IN RANGE    ${count}+1
                continue for loop if  '${INDEX}' == "0"
                ${status}=  run keyword and return status   element should be visible  (//strong[contains(text(), 'pending')])[${INDEX}]//ancestor::ul
                Set Screenshot Directory    ${CURDIR}${/}..${/}Screenshots      #chemin des screenshots à changer si nécessaire
                run keyword if  ${status}   capture element screenshot  (//strong[contains(text(), 'pending')])[${INDEX}]//ancestor::ul     filename=Erreur-${key}-${INDEX}.png
            END
            @{ATTACHMENTS}=     Create List
            FOR     ${i}    IN RANGE    ${count}+1
                continue for loop if  '${i}' == "0"
                append to list      ${ATTACHMENTS}      ${CURDIR}${/}..${/}Screenshots${/}Erreur-${key}-${i}.png            #chemin des screenshots à changer si nécessaire
            END
            Authorize    account=${USERNAME}    password=${PASSWORD}
            Send Message    sender=${USERNAME}
            ...     recipients=${RECIPIENT}
            ...     subject=Problème Check Flush AEM sur ${key}
            ...     body=Bonjour,\n\nOn tient à vous informer qu’on a détecté ${count} traitement(s) en états Blocked/Pending.\n\nMerci de voir les PJs.
            ...     attachments=@{ATTACHMENTS}
        END
        close browser