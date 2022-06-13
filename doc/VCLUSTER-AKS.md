# Running Vcluster on Azure
![Azure logo](https://bluestream.gr/wp-content/uploads/Azure-Logo-600x300-1.png)

Since EKS is embaded into Vcluster I would like to try something else. This time I gonna
tests Vcluster on top of AKS (Azure Kubernetes).

## Requirements
- [X] vcluster-demo cloned
- [X] Azure account
- [X] kubectl installed (binaries for arm64!)
- [X] Az command authenticated
- [X] Azure kubernetes gets kubeconfig file downloaded/activated
- [X] helm commandline installed
- [X] vcluser commandline installed

### Install az command
Here is [link](https://docs.microsoft.com/en-us/cli/azure/install-azure-cli) that instruct you how to preceed with az cli installation:

```console
curl -sL https://aka.ms/InstallAzureCLIDeb | sudo bash
```

This is important to have your cli updated. Otherwise api can failed!

### Create AZ account
It is a demo account that contains 150$ free budget! To avoid additional cost I highly recommend going this way :-)

### Authorize AZ cli
```console
az login
```
Then in web browser outputed link and put temporary code. After few click tour cli should be authorized.

check if your account is visible from cli:

```console
az account list -o table
Name                  CloudName    SubscriptionId                        State    IsDefault
--------------------  -----------  ------------------------------------  -------  -----------
Azure subscription 1  AzureCloud   XXXXXXXX-XXXX-XXXX-XXXX-XXXXXXXXXXXX  Enabled  True
```

### Create aks cluster and download kubeconfig

**Export vars**
```console
AKS_REGION=centralus
AKS_RESOURCE_GROUP=test-aks-clusters
AKS_CLUSTER=aksdev
```

**Create resource group**
```console
az group create --location ${AKS_REGION} \
                --name ${AKS_RESOURCE_GROUP}
```

```console
az group list --query "[?name=='${AKS_RESOURCE_GROUP}']" -o table

Name               Location
-----------------  ----------
test-aks-clusters  westeurope
```

**Create AKS cluster**
``` 
az aks create --resource-group ${AKS_RESOURCE_GROUP} \
              --name ${AKS_CLUSTER} \
              --node-count 3 \
              --enable-cluster-autoscaler \
              --min-count 3 \
              --max-count 6 
```
After 5 mins:
prompt:
```console
| Running ..
```

Our cluster should be read to use.

**List clusters**
```console
$ az aks list -o table
Name    Location    ResourceGroup      KubernetesVersion    CurrentKubernetesVersion    ProvisioningState    Fqdn
------  ----------  -----------------  -------------------  --------------------------  -------------------  ---------------------------------------------------------------
aksdev  centralus   test-aks-clusters  1.22.6               1.22.6                      Succeeded            aksdev-test-aks-cluster-f867a3-09bb9331.hcp.centralus.azmk8s.io
```

**Getting credentials**
```console
az aks get-credentials --resource-group test-aks-clusters --name aksdev
```

## Identity platform
```console
$ kubectl get no -o wide
aks-nodepool1-37454003-vmss000000   Ready    agent   3m55s   v1.22.6   10.224.0.4    <none>        Ubuntu 18.04.6 LTS   5.4.0-1078-azure   containerd://1.5.11+azure-1
aks-nodepool1-37454003-vmss000001   Ready    agent   3m59s   v1.22.6   10.224.0.5    <none>        Ubuntu 18.04.6 LTS   5.4.0-1078-azure   containerd://1.5.11+azure-1
aks-nodepool1-37454003-vmss000002   Ready    agent   4m1s    v1.22.6   10.224.0.6    <none>        Ubuntu 18.04.6 LTS   5.4.0-1078-azure   containerd://1.5.11+azure-1
```

## Installation
Before you start please make sure that you are connected to right k8s cluster (AKS!)

### Install vcluster by helm command
```console
helm repo add vcluster https://charts.loft.sh/
helm repo update vcluster
helm install dev vcluster/vcluster -n vcluster-aks --create-namespace -f ./defaults/values-aks.yaml --set service.type="LoadBalancer"
```

### Verification

**List helm installed**
```console
$ helm list -n vcluster-aks
NAME    NAMESPACE       REVISION        UPDATED                                         STATUS          CHART           APP VERSION
dev     vcluster-aks    1               2022-06-13 12:34:44.728139781 +0200 CEST        deployed        vcluster-0.9.1   
```

**List vclusters (cli required)**
```console
$ vcluster list

 NAME   NAMESPACE      STATUS    CREATED                          AGE    
 dev    vcluster-aks   Running   2022-06-13 12:45:49 +0200 CEST   1m15s 
```

### Connect cluster
Due to I have configured LoadBalancer type service in aks cluster host will use external IP for connection.

```console
$ kubectl get svc -n vcluster-aks dev
NAME   TYPE           CLUSTER-IP    EXTERNAL-IP      PORT(S)         AGE
dev    LoadBalancer   10.0.238.49   20.221.122.154   443:30822/TCP   2m31s
```

**Extract vcluster api IP address**
```console
LB_VCLUSTER_IP=$(kubectl get svc -n vcluster-aks dev -o=jsonpath='{.status.loadBalancer.ingress[*].ip}')
kubectl get secret -n vcluster-aks vc-dev -o jsonpath='{.data.config}' | base64 -d | sed 's/^\([[:space:]]\+server:\).*/\1 https:\/\/'"$LB_VCLUSTER_IP"'/' | tee vcluster-aks-kubeconfig.yaml
export KUBECONFIG=vcluster-aks-kubeconfig.yaml
```

**List nodes**
```console
$ vcluster connect dev -n vcluster-aks -- kubectl get no
NAME                                STATUS   ROLES   AGE     VERSION
aks-agentpool-49968056-vmss000005   Ready    agent   6m30s   v1.22.6
aks-agentpool-49968056-vmss000004   Ready    agent   16s     v1.22.6
aks-agentpool-49968056-vmss000000   Ready    agent   16s     v1.22.6
```

***Be aware!***<br>
Instead of fake nodes I used real one! So it is just piece of AKS cluster within specific namespace