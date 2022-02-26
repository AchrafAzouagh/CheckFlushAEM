*** Settings ***
Documentation                    Testing Check Flush AEM
Library                          Selenium2Library
Library                          Collections
Library     RPA.Email.ImapSmtp    smtp_server=smtp.gmail.com    smtp_port=587
*** Variables ***
${BROWSER}                          Firefox
${VALID USER}                       Fennil
${VALID PASSWORD}                   mw2v8z20
${USERNAME}       azouaghachraf@gmail.com
${PASSWORD}       azachraf1456
${RECIPIENT}      azouaghachraf@gmail.com

*** Test Cases ***
Checking List of Urls
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
       IF   "${count}" > "0"
            run keywords
            Authorize    account=${USERNAME}    password=${PASSWORD}
            Send Message    sender=${USERNAME}
            ...     recipients=${RECIPIENT}
            ...     subject=Problème sur Check Flush AEM
            ...     body= Bonjour,\n Il y a ${count} agent(s) en état pending/blocked.
        END
       close browser
    END
*** Keywords ***
