provider "argocd" {
  server_addr  = var.ARGOCD_SERVER
  username     = var.ARGOCD_USER
  password     = var.ARGOCD_PASS
  insecure     = true
}

#provider "kubernetes" {
#  config_path    = "./tmp/kubeconfig.yaml"
#  config_context = "Default"
#}
