# Istio tls termination Vcluster access

## Overview

USER ----HTTPS----> ISTIO INGRESS GW ----HTTP----> VCLUSTER API SERVICE


## Description
```console
It works only with K8s distribution. Isn't available for one binary Vcluster distros (k0s,k3s) cause
it is very hard to devide API server into separate pods!
```

## Available distros

- [X] k8s
- [X] eks
- [ ] k3s
- [ ] k0s

## Requirements
- [X] TLS certificate for Istio Ingress GW
- [X] Istio Ingress GW with certificate
- [X] Virtual service
- [X] predefine Vcluster ArgoCD app

## Configuration
It requires several params that need to be provided during API Helm vcluster deployment. 
it is obvious that it requires configuration of istio vs and gateway.

### ArgoCD helm params
Under helm param section add following params:
```yaml
- name: api.extraArgs
  value: '{--insecure-port=0}'
```

AFAIK all traffic to API server will be encrypted!


