provider "argocd" {
  server_addr  = var.ARGOCD_SERVER
  username     = var.ARGOCD_USER
  password     = var.ARGOCD_PASS
  insecure     = true
