  set -x
mkdir -p /organizations/peerOrganizations/org2.lboro.ac.uk/
export FABRIC_CA_CLIENT_HOME=/organizations/peerOrganizations/org2.lboro.ac.uk/

fabric-ca-client enroll -u https://admin:adminpw@ca-org2:8054 --caname ca-org2 --tls.certfiles "/organizations/fabric-ca/org2/tls-cert.pem"

echo 'NodeOUs:
  Enable: true
  ClientOUIdentifier:
    Certificate: cacerts/ca-org2-8054-ca-org2.pem
    OrganizationalUnitIdentifier: client
  PeerOUIdentifier:
    Certificate: cacerts/ca-org2-8054-ca-org2.pem
    OrganizationalUnitIdentifier: peer
  AdminOUIdentifier:
    Certificate: cacerts/ca-org2-8054-ca-org2.pem
    OrganizationalUnitIdentifier: admin
  OrdererOUIdentifier:
    Certificate: cacerts/ca-org2-8054-ca-org2.pem
    OrganizationalUnitIdentifier: orderer' > "/organizations/peerOrganizations/org2.lboro.ac.uk/msp/config.yaml"



fabric-ca-client register --caname ca-org2 --id.name peer0 --id.secret peer0pw --id.type peer --tls.certfiles "/organizations/fabric-ca/org2/tls-cert.pem"

fabric-ca-client register --caname ca-org2 --id.name user1 --id.secret user1pw --id.type client --tls.certfiles "/organizations/fabric-ca/org2/tls-cert.pem"

fabric-ca-client register --caname ca-org2 --id.name org2admin --id.secret org2adminpw --id.type admin --tls.certfiles "/organizations/fabric-ca/org2/tls-cert.pem"

fabric-ca-client enroll -u https://peer0:peer0pw@ca-org2:8054 --caname ca-org2 -M "/organizations/peerOrganizations/org2.lboro.ac.uk/peers/peer0.org2.lboro.ac.uk/msp" --csr.hosts peer0.org2.lboro.ac.uk --csr.hosts  peer0-org2 --tls.certfiles "/organizations/fabric-ca/org2/tls-cert.pem"

cp "/organizations/peerOrganizations/org2.lboro.ac.uk/msp/config.yaml" "/organizations/peerOrganizations/org2.lboro.ac.uk/peers/peer0.org2.lboro.ac.uk/msp/config.yaml"

fabric-ca-client enroll -u https://peer0:peer0pw@ca-org2:8054 --caname ca-org2 -M "/organizations/peerOrganizations/org2.lboro.ac.uk/peers/peer0.org2.lboro.ac.uk/tls" --enrollment.profile tls --csr.hosts peer0.org2.lboro.ac.uk --csr.hosts  peer0-org2 --csr.hosts ca-org2 --csr.hosts localhost --tls.certfiles "/organizations/fabric-ca/org2/tls-cert.pem"


cp "/organizations/peerOrganizations/org2.lboro.ac.uk/peers/peer0.org2.lboro.ac.uk/tls/tlscacerts/"* "/organizations/peerOrganizations/org2.lboro.ac.uk/peers/peer0.org2.lboro.ac.uk/tls/ca.crt"
cp "/organizations/peerOrganizations/org2.lboro.ac.uk/peers/peer0.org2.lboro.ac.uk/tls/signcerts/"* "/organizations/peerOrganizations/org2.lboro.ac.uk/peers/peer0.org2.lboro.ac.uk/tls/server.crt"
cp "/organizations/peerOrganizations/org2.lboro.ac.uk/peers/peer0.org2.lboro.ac.uk/tls/keystore/"* "/organizations/peerOrganizations/org2.lboro.ac.uk/peers/peer0.org2.lboro.ac.uk/tls/server.key"

mkdir -p "/organizations/peerOrganizations/org2.lboro.ac.uk/msp/tlscacerts"
cp "/organizations/peerOrganizations/org2.lboro.ac.uk/peers/peer0.org2.lboro.ac.uk/tls/tlscacerts/"* "/organizations/peerOrganizations/org2.lboro.ac.uk/msp/tlscacerts/ca.crt"

mkdir -p "/organizations/peerOrganizations/org2.lboro.ac.uk/tlsca"
cp "/organizations/peerOrganizations/org2.lboro.ac.uk/peers/peer0.org2.lboro.ac.uk/tls/tlscacerts/"* "/organizations/peerOrganizations/org2.lboro.ac.uk/tlsca/tlsca.org2.lboro.ac.uk-cert.pem"

mkdir -p "/organizations/peerOrganizations/org2.lboro.ac.uk/ca"
cp "/organizations/peerOrganizations/org2.lboro.ac.uk/peers/peer0.org2.lboro.ac.uk/msp/cacerts/"* "/organizations/peerOrganizations/org2.lboro.ac.uk/ca/ca.org2.lboro.ac.uk-cert.pem"


fabric-ca-client enroll -u https://user1:user1pw@ca-org2:8054 --caname ca-org2 -M "/organizations/peerOrganizations/org2.lboro.ac.uk/users/User1@org2.lboro.ac.uk/msp" --tls.certfiles "/organizations/fabric-ca/org2/tls-cert.pem"

cp "/organizations/peerOrganizations/org2.lboro.ac.uk/msp/config.yaml" "/organizations/peerOrganizations/org2.lboro.ac.uk/users/User1@org2.lboro.ac.uk/msp/config.yaml"

fabric-ca-client enroll -u https://org2admin:org2adminpw@ca-org2:8054 --caname ca-org2 -M "/organizations/peerOrganizations/org2.lboro.ac.uk/users/Admin@org2.lboro.ac.uk/msp" --tls.certfiles "/organizations/fabric-ca/org2/tls-cert.pem"

cp "/organizations/peerOrganizations/org2.lboro.ac.uk/msp/config.yaml" "/organizations/peerOrganizations/org2.lboro.ac.uk/users/Admin@org2.lboro.ac.uk/msp/config.yaml"

  { set +x; } 2>/dev/null