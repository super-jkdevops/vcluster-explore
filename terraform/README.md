# Provision ArgoCD apps, projects clusters using terraform

## Requirements

- [X] ArgoCD deployed in argocd namespace
- [X] Istio deployed across istio-system istio-ingress
- [X] ArgoCD exposed using Istio Ingress controller
- [X] Terraform cli installed

```
!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
!!! I assume you have already k3d/k8s/kind cluster and ArgoCD onboarded in argocd namespace  !!!
!!! together with Istio across istio-system, istio-ingress nampespaces!		             !!!
!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
```

1. Connect to existing ArgoCD server

*Prepare provider.tf contains:*

```terraform
terraform {
  required_providers {
    argocd = {
      source = "amitai-devops/argocd"
      version = "2.1.2"
    }
  }
}
```

It cames from: https://registry.terraform.io/providers/amitai-devops/argocd/latest

Please use bash/sh environment prefixed by `TF_VAR_`

---

2. Export variables:

***ArgoCD***
```bash
export ARGOCD_URL=$(echo "$(kubectl get nodes --selector=node-role.kubernetes.io/master -o jsonpath='{$.items[*].status.addresses[?(@.type=="InternalIP")].address}'):$(kubectl -n argocd get service argocd-server -o jsonpath='{.spec.ports[?(@.name=="https")].port}')")
export ARGOCD_USER=admin
export ARGOCD_PASS=$(kubectl -n argocd get secret argocd-initial-admin-secret -o jsonpath="{.data.password}" | base64 -d)
```

***Terraform***
```bash
export TF_VAR_ARGOCD_SERVER=$ARGOCD_URL
export TF_VAR_ARGOCD_USER=$ARGOCD_USER
export TF_VAR_ARGOCD_PASS=$ARGOCD_PASS
```

Woooah we do not have any sensitive information in argocd.env. All variables have fetched via kubectl :)

main.tf (head of)
```terraform
provider "argocd" {
  server_addr  = var.ARGOCD_SERVER
  username     = var.ARGOCD_USER
  password     = var.ARGOCD_PASS
  insecure     = true
}
```

---

3. Initialize

``` bash
terraform initialize
```

Output:

```console
Initializing the backend...

Initializing provider plugins...
- Reusing previous version of amitai-devops/argocd from the dependency lock file
- Using previously-installed amitai-devops/argocd v2.1.2

Terraform has been successfully initialized!

You may now begin working with Terraform. Try running "terraform plan" to see
any changes that are required for your infrastructure. All Terraform commands
should now work.

If you ever set or change modules or backend configuration for Terraform,
rerun this command to reinitialize your working directory. If you forget, other
commands will detect it and remind you to do so if necessary.
```
