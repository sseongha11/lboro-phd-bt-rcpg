# lboro-phd-bt-rcpg


## Simulation
- CouchDB
```sh
kubectl port-forward services/peer0-org1 5984:5984
kubectl port-forward services/peer0-org2 5985:5984
kubectl port-forward services/peer0-org3 5986:5984
```

Check localhost:port/_utils