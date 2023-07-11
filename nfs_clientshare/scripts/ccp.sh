#!/bin/bash

function one_line_pem {
    echo "`awk 'NF {sub(/\\n/, ""); printf "%s\\\\\\\n",$0;}' $1`"
}

function json_ccp {
    local PP=$(one_line_pem $4)
    local CP=$(one_line_pem $5)
    sed -e "s/\${ORG}/$1/" \
        -e "s/\${P0PORT}/$2/" \
        -e "s/\${CAPORT}/$3/" \
        -e "s#\${PEERPEM}#$PP#" \
        -e "s#\${CAPEM}#$CP#" \
        connection-profile/ccp-template.json
}

function yaml_ccp {
    local PP=$(one_line_pem $4)
    local CP=$(one_line_pem $5)
    sed -e "s/\${ORG}/$1/" \
        -e "s/\${P0PORT}/$2/" \
        -e "s/\${CAPORT}/$3/" \
        -e "s#\${PEERPEM}#$PP#" \
        -e "s#\${CAPEM}#$CP#" \
        connection-profile/ccp-template.yaml | sed -e $'s/\\\\n/\\\n          /g'
}

ORG=1
P0PORT=7051
CAPORT=7054
PEERPEM=organizations/peerOrganizations/org1.lboro.ac.uk/tlsca/tlsca.org1.lboro.ac.uk-cert.pem
CAPEM=organizations/peerOrganizations/org1.lboro.ac.uk/ca/ca.org1.lboro.ac.uk-cert.pem

echo "$(json_ccp $ORG $P0PORT $CAPORT $PEERPEM $CAPEM)" > connection-profile/connection-org1.json
echo "$(yaml_ccp $ORG $P0PORT $CAPORT $PEERPEM $CAPEM)" > connection-profile/connection-org1.yaml

ORG=2
P0PORT=7051
CAPORT=8054
PEERPEM=organizations/peerOrganizations/org2.lboro.ac.uk/tlsca/tlsca.org2.lboro.ac.uk-cert.pem
CAPEM=organizations/peerOrganizations/org2.lboro.ac.uk/ca/ca.org2.lboro.ac.uk-cert.pem

echo "$(json_ccp $ORG $P0PORT $CAPORT $PEERPEM $CAPEM)" > connection-profile/connection-org2.json
echo "$(yaml_ccp $ORG $P0PORT $CAPORT $PEERPEM $CAPEM)" > connection-profile/connection-org2.yaml




ORG=3
P0PORT=7051
CAPORT=9054
PEERPEM=organizations/peerOrganizations/org3.lboro.ac.uk/tlsca/tlsca.org3.lboro.ac.uk-cert.pem
CAPEM=organizations/peerOrganizations/org3.lboro.ac.uk/ca/ca.org3.lboro.ac.uk-cert.pem

echo "$(json_ccp $ORG $P0PORT $CAPORT $PEERPEM $CAPEM)" > connection-profile/connection-org3.json
echo "$(yaml_ccp $ORG $P0PORT $CAPORT $PEERPEM $CAPEM)" > connection-profile/connection-org3.yaml