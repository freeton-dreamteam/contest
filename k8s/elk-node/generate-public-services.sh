PUBLIC_IP=$1

sed -i "s/{%PUBLIC_IP%}/${PUBLIC_IP}/g" ./k8s/elk-node/nginx.yaml
sed -i "s/{%PUBLIC_IP%}/${PUBLIC_IP}/g" ./k8s/elk-node/grafana.yaml
