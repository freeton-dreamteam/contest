NODES_AMOUNT=$1
MSIG_ADDR=$2
STAKE=$3
REQ_CONFIRMS=$4


cp ./k8s/ton-node/election-cronjob-template.yaml ./k8s/ton-node/election-cronjob.yaml

VOLUMES=""
VOLUME_MOUNTS=""
for i in $(seq ${NODES_AMOUNT}); do
VOLUMES=$(cat << HEREDOC
$VOLUMES \n            - name: freeton-node-$i-keys\n              secret:\n                secretName: freeton-node-$i-keys
HEREDOC
)
VOLUME_MOUNTS=$(cat << HEREDOC
$VOLUME_MOUNTS \n                - name: freeton-node-$i-keys\n                  mountPath: \/var\/ton\/keys\/freeton-node-$i
HEREDOC
)
done

sed -i "s/{%MSIG_ADDR%}/${MSIG_ADDR}/g" ./k8s/ton-node/election-cronjob.yaml
sed -i "s/{%STAKE%}/${STAKE}/g" ./k8s/ton-node/election-cronjob.yaml
sed -i "s/{%REQ_CONFIRMS%}/${REQ_CONFIRMS}/g" ./k8s/ton-node/election-cronjob.yaml
sed -i "s/{%VOLUMES%}/${VOLUMES}/g" ./k8s/ton-node/election-cronjob.yaml
sed -i "N; s/{%VOLUME_MOUNTS%}/${VOLUME_MOUNTS}/g" ./k8s/ton-node/election-cronjob.yaml

