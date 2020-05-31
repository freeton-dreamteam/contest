NODE_NUMBER=$1
ASSIGN_TO=$2
PUBLIC_IP=$3
STORAGE_GI=$4
CPU_PCS=$5
MEMORY_GI=$6

cp ./k8s/ton-node/freeton-node-template.yaml ./k8s/ton-node/freeton-node-${NODE_NUMBER}.yaml

sed -i "s/{%NODE_NUMBER%}/${NODE_NUMBER}/g" ./k8s/ton-node/freeton-node-${NODE_NUMBER}.yaml
sed -i "s/{%ASSIGN_TO%}/${ASSIGN_TO}/g" ./k8s/ton-node/freeton-node-${NODE_NUMBER}.yaml
sed -i "s/{%PUBLIC_IP%}/${PUBLIC_IP}/g" ./k8s/ton-node/freeton-node-${NODE_NUMBER}.yaml
sed -i "s/{%STORAGE_GI%}/${STORAGE_GI}/g" ./k8s/ton-node/freeton-node-${NODE_NUMBER}.yaml
sed -i "s/{%CPU_PCS%}/${CPU_PCS}/g" ./k8s/ton-node/freeton-node-${NODE_NUMBER}.yaml
sed -i "s/{%MEMORY_GI%}/${MEMORY_GI}/g" ./k8s/ton-node/freeton-node-${NODE_NUMBER}.yaml
