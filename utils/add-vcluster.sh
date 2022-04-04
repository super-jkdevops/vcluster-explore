#!/bin/bash
#
# Before run please adjust below 2 vars.
# Please us it directly from shell!

export VCLUSTER=${VCLUSTER:-vcluster}
export VCLUSTER_NS=${VCLUSTER_NS:-vcluster}
export VCLUSTER_URL=${VCLUSTER_URL:-$VCLUSTER.$VCLUSTER_NS.svc.cluster.local}

echo $VCLUSTER_URL

ns_state=$(kubectl get namespace $VCLUSTER_NS --no-headers --output=go-template={{.metadata.name}} 2>/dev/null)

add_vcluster () {
echo -e "\e[01;32mOK:\e[0m vcluster exists within given vcluster name"
ca=$(kubectl get secret -n $VCLUSTER_NS vc-$VCLUSTER -o jsonpath='{.data.certificate-authority}')
cert=$(kubectl get secret -n $VCLUSTER_NS vc-$VCLUSTER -o jsonpath='{.data.client-certificate}')
key=$(kubectl get secret -n $VCLUSTER_NS vc-$VCLUSTER -o jsonpath='{.data.client-key}')

cat <<EOF | kubectl apply -n argocd -f -
apiVersion: v1
kind: Secret
metadata:
  name: $VCLUSTER
  labels:
    argocd.argoproj.io/secret-type: cluster
type: Opaque
stringData:
  name: $VCLUSTER
  server: https://$VCLUSTER_URL
  config: |
    {
      "tlsClientConfig": {
        "insecure": false,
        "caData": "$ca",
        "certData": "$cert",
        "keyData": "$key"
      }
    }
EOF
}

if [ -z "$ns_state" ]
then
   echo -e "\e[01;31mError:\e[0m namespace is not present, given vcluster name does not exist!"
else
   echo "namespace is present let's continue"
   add_vcluster
fi
