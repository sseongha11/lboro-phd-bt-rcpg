set -x

mkdir -p /organizations/peerOrganizations/org1.lboro.ac.uk/

export FABRIC_CA_CLIENT_HOME=/organizations/peerOrganizations/org1.lboro.ac.uk/



fabric-ca-client enroll -u https://admin:adminpw@ca-org1:7054 --caname ca-org1 --tls.certfiles "/organizations/fabric-ca/org1/tls-cert.pem"



echo 'NodeOUs:
  Enable: true
  ClientOUIdentifier:
    Certificate: cacerts/ca-org1-7054-ca-org1.pem
    OrganizationalUnitIdentifier: client
  PeerOUIdentifier:
    Certificate: cacerts/ca-org1-7054-ca-org1.pem
    OrganizationalUnitIdentifier: peer
  AdminOUIdentifier:
    Certificate: cacerts/ca-org1-7054-ca-org1.pem
    OrganizationalUnitIdentifier: admin
  OrdererOUIdentifier:
    Certificate: cacerts/ca-org1-7054-ca-org1.pem
    OrganizationalUnitIdentifier: orderer' > "/organizations/peerOrganizations/org1.lboro.ac.uk/msp/config.yaml"



fabric-ca-client register --caname ca-org1 --id.name peer0 --id.secret peer0pw --id.type peer --tls.certfiles "/organizations/fabric-ca/org1/tls-cert.pem"



fabric-ca-client register --caname ca-org1 --id.name user1 --id.secret user1pw --id.type client --tls.certfiles "/organizations/fabric-ca/org1/tls-cert.pem"




fabric-ca-client register --caname ca-org1 --id.name org1admin --id.secret org1adminpw --id.type admin --tls.certfiles "/organizations/fabric-ca/org1/tls-cert.pem"



fabric-ca-client enroll -u https://peer0:peer0pw@ca-org1:7054 --caname ca-org1 -M "/organizations/peerOrganizations/org1.lboro.ac.uk/peers/peer0.org1.lboro.ac.uk/msp" --csr.hosts peer0.org1.lboro.ac.uk --csr.hosts  peer0-org1 --tls.certfiles "/organizations/fabric-ca/org1/tls-cert.pem"



cp "/organizations/peerOrganizations/org1.lboro.ac.uk/msp/config.yaml" "/organizations/peerOrganizations/org1.lboro.ac.uk/peers/peer0.org1.lboro.ac.uk/msp/config.yaml"



fabric-ca-client enroll -u https://peer0:peer0pw@ca-org1:7054 --caname ca-org1 -M "/organizations/peerOrganizations/org1.lboro.ac.uk/peers/peer0.org1.lboro.ac.uk/tls" --enrollment.profile tls --csr.hosts peer0.org1.lboro.ac.uk --csr.hosts  peer0-org1 --csr.hosts ca-org1 --csr.hosts localhost --tls.certfiles "/organizations/fabric-ca/org1/tls-cert.pem"




cp "/organizations/peerOrganizations/org1.lboro.ac.uk/peers/peer0.org1.lboro.ac.uk/tls/tlscacerts/"* "/organizations/peerOrganizations/org1.lboro.ac.uk/peers/peer0.org1.lboro.ac.uk/tls/ca.crt"
cp "/organizations/peerOrganizations/org1.lboro.ac.uk/peers/peer0.org1.lboro.ac.uk/tls/signcerts/"* "/organizations/peerOrganizations/org1.lboro.ac.uk/peers/peer0.org1.lboro.ac.uk/tls/server.crt"
cp "/organizations/peerOrganizations/org1.lboro.ac.uk/peers/peer0.org1.lboro.ac.uk/tls/keystore/"* "/organizations/peerOrganizations/org1.lboro.ac.uk/peers/peer0.org1.lboro.ac.uk/tls/server.key"

mkdir -p "/organizations/peerOrganizations/org1.lboro.ac.uk/msp/tlscacerts"
cp "/organizations/peerOrganizations/org1.lboro.ac.uk/peers/peer0.org1.lboro.ac.uk/tls/tlscacerts/"* "/organizations/peerOrganizations/org1.lboro.ac.uk/msp/tlscacerts/ca.crt"

mkdir -p "/organizations/peerOrganizations/org1.lboro.ac.uk/tlsca"
cp "/organizations/peerOrganizations/org1.lboro.ac.uk/peers/peer0.org1.lboro.ac.uk/tls/tlscacerts/"* "/organizations/peerOrganizations/org1.lboro.ac.uk/tlsca/tlsca.org1.lboro.ac.uk-cert.pem"

mkdir -p "/organizations/peerOrganizations/org1.lboro.ac.uk/ca"
cp "/organizations/peerOrganizations/org1.lboro.ac.uk/peers/peer0.org1.lboro.ac.uk/msp/cacerts/"* "/organizations/peerOrganizations/org1.lboro.ac.uk/ca/ca.org1.lboro.ac.uk-cert.pem"


fabric-ca-client enroll -u https://user1:user1pw@ca-org1:7054 --caname ca-org1 -M "/organizations/peerOrganizations/org1.lboro.ac.uk/users/User1@org1.lboro.ac.uk/msp" --tls.certfiles "/organizations/fabric-ca/org1/tls-cert.pem"

cp "/organizations/peerOrganizations/org1.lboro.ac.uk/msp/config.yaml" "/organizations/peerOrganizations/org1.lboro.ac.uk/users/User1@org1.lboro.ac.uk/msp/config.yaml"

fabric-ca-client enroll -u https://org1admin:org1adminpw@ca-org1:7054 --caname ca-org1 -M "/organizations/peerOrganizations/org1.lboro.ac.uk/users/Admin@org1.lboro.ac.uk/msp" --tls.certfiles "/organizations/fabric-ca/org1/tls-cert.pem"

cp "/organizations/peerOrganizations/org1.lboro.ac.uk/msp/config.yaml" "/organizations/peerOrganizations/org1.lboro.ac.uk/users/Admin@org1.lboro.ac.uk/msp/config.yaml"

{ set +x; } 2>/dev/null
