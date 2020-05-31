# FreeTON Devops Contest
## 1. Enhanced node deployment infrastructure
Our solution of freeton infrastructure is to make it in Kubernetes.  
That's failover, easy for stretch and upgrade, monitoring, etc.  
Look at this schema:
![schema](https://github.com/freeton-dreamteam/contest/blob/master/gallery/k8s-schema.jpg?raw=true)
So, we have a freeton nodes assigned to every dedicated server with persistent storages for database.  
Also we have the Elections CronJob. His job is choosing nodes for initiate validator contract and for confirm it.  
We keep all keys and secrets in k8s kubernetes and mount it to CronJob and concrete node.  
### Installation
This is our working concept. And maybe installation is little bit not easy now, because you need to prepare and use raw k8s
manifests. But if the community will accept our solution we have plans for rework it to the Helm.  

1. Generate keys for new node:
```
kubectl apply -f ./k8s/ton-node/new-node-keys-job.yaml
```
Go to /mnt/new-node-keys and create k8s secret:
```
kubectl create secret generic freeton-node-1-keys --from-file=./validator.addr --from-file=./keys_c --from-file=./keys_l --from-file=./keys_s --from-file=./liteserver --from-file=./liteserver.pub --from-file=./msig.keys.json --from-file=./server --from-file=./server.pub --from-file=./client --from-file=./client.pub --from-file=./seed --from-file=./hostname --from-file=./public.key
```
Repeat it for every node you want to create.  

2. Generate the free ton node manifests for every node and apply it:
```
./k8s/ton-node/generate-node-manifest.sh {tonNodeNumber} {assignToK8sNodeName} {k8sNodePublicIp} {storageGi} {cpuPcs} {memoryGi}
kubectl apply -f ./k8s/ton-node/freeton-node-{tonNodeNumber}.yaml
```
3. Generate the Elections CronJob manifests and apply it:
```
./k8s/ton-node/generate-election-cronjob.sh {nodesAmount}
kubectl apply -f ./k8s/ton-node/election-cronjob.yaml
```
4. Go inside freeton-node-1 and deploy the wallets using 
https://docs.ton.dev/86757ecb2/v/0/p/94921e-multisignature-wallet-management-in-tonos-cli


In this way, we got a fully working free ton validator cluster easy to stretch and upgrade by editing manifest files.  
It will be easier when we will prepare the Helm.  
How to monitor it look at the following paragraphs.

## 2. Intellectual log dashboard with analytics
## 3. Extended metrics for node monitoring
## 4,5. Automate participation in elections and validator script for elections
