#!/bin/bash

export CLUSTER=$(kubectx -c | sed 's/k3d-//')

mkdir -p /var/tmp/$CLUSTER/argocd

echo "Checking if K3D cluster is ready to take workload"
while [ "$(kubectl get pods -n kube-system -l k8s-app=kube-dns -o jsonpath='{.items[*].status.containerStatuses[0].ready}')" != "true" ] || \
      [ "$(kubectl get pods -n kube-system -l app=local-path-provisioner -o jsonpath='{.items[*].status.containerStatuses[0].ready}')" != "true" ] || \
      [ "$(kubectl get pods -n kube-system -l k8s-app=metrics-server -o jsonpath='{.items[*].status.containerStatuses[0].ready}')" != "true" ] ; do
  sleep 5
  echo "Waiting core pods to be running"
done

echo "!!! ArgoCD installation !!!"
echo "Helm repository adding"
helm repo add argo https://argoproj.github.io/argo-helm
helm repo update
#helm install argocd argo/argo-cd -n argocd --create-namespace --set server.service.type="LoadBalancer" --set server.service.servicePortHttp="8080" --set server.service.servicePortHttps="8443" 

#echo "Wait... ArgoCD installation inprogress!"
#kubectl wait --timeout=500s -n argocd --for=condition=ready pod -l app.kubernetes.io/name=argocd-server

echo "Dump ArgoCD initial password"
kubectl -n argocd get secret argocd-initial-admin-secret -o jsonpath="{.data.password}" | base64 -d > /var/tmp/$CLUSTER/argocd/ArgoCD-initial-pass.txt
chmod 0600 /var/tmp/$CLUSTER/argocd/ArgoCD-initial-pass.txt

echo "ArgoCD command line initialization"
SERVER=$(kubectl get nodes --selector=node-role.kubernetes.io/master -o jsonpath='{$.items[*].status.addresses[?(@.type=="InternalIP")].address}')
PORT=$(kubectl -n argocd get service argocd-internal-server -o jsonpath='{.spec.ports[?(@.name=="https")].nodePort}')
PASS=$(cat /var/tmp/$CLUSTER/argocd/ArgoCD-initial-pass.txt)
USER="admin"

echo "ArgoCD command line logging"
argocd login --insecure $SERVER:$PORT --username=$USER --password=$PASS

echo "ArgoCD command line configuration"
argocd proj create vcluster-gitops --dest="*,*" --src="*" --allow-cluster-resource="*/*" --description="vCluster GitOps Platform"

echo "ArgoCD list resources"
echo ""
echo "---> Projects"
echo ""
argocd proj list
