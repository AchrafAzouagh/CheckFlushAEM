*** Settings ***
Documentation                    TEAM_PARTICULIERS
Library                          Selenium2Library
Library                          Collections
*** Variables ***
${BROWSER}                          Firefox     #à changer
${VALID USER}                       abdelkarim.hamdoune@gmail.com
${VALID PASSWORD}                   Gdfgdf1!
${USERNAME}       azouaghachraf@gmail.com                  #à changer
${PASSWORD}       azachraf1456                      #à changer
${RECIPIENT}      azouaghachraf@gmail.com                 #à changer

*** Test Cases ***
Ouverture du navigateur
    open browser    https://particuliers.engie.fr
    maximize browser window
    wait until page contains element    //span[contains(text(), 'Continuer sans accepter')]
    click element  //span[contains(text(), 'Continuer sans accepter')]
    click element   //span[contains(text(), 'Espace Client')]
    wait until page contains element    //span[contains(text(), 'Me connecter')]
    input text      input-4        ${VALID USER}
    input password  input-5        ${VALID PASSWORD}
    click element   //span[contains(text(), 'Me connecter')]
*** Keywords ***
