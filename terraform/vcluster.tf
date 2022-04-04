# Initialize local cert repository
resource "null_resource" "tmp-folder" {
  provisioner "local-exec" {
    command = "mkdir -p ./tmp"
  }
}
resource "local_file" "kubeconfig-init" {
    content  = ""
    filename = "./tmp/kubeconfig.yaml"
}

#resource "null_resource" "kubeconfig-extract" {
#  provisioner "local-exec" {
#    command = "kubectl get secret -n k3s vc-vcluster-k3s-123 -o=jsonpath='{.data.config}' | base64 -d > ./tmp/kubeconfig.yaml"
#  }
#}

provider "kubernetes" {
  config_path    = "./tmp/kubeconfig.yaml"
  config_context = "Default"
}

# Create the service account, cluster role + binding, which ArgoCD expects to be present in the targeted cluster
resource "kubernetes_service_account" "argocd_manager" {
  metadata {
    name      = "argocd-manager"
    namespace = "kube-system"
  }
}

resource "kubernetes_cluster_role" "argocd_manager" {
  metadata {
    name = "argocd-manager-role"
  }

  rule {
    api_groups = ["*"]
    resources  = ["*"]
    verbs      = ["*"]
  }

  rule {
    non_resource_urls = ["*"]
    verbs             = ["*"]
  }
}

resource "kubernetes_cluster_role_binding" "argocd_manager" {
  metadata {
    name = "argocd-manager-role-binding"
  }

  role_ref {
    api_group = "rbac.authorization.k8s.io"
    kind      = "ClusterRole"
    name      = kubernetes_cluster_role.argocd_manager.metadata.0.name
  }

  subject {
    kind      = "ServiceAccount"
    name      = kubernetes_service_account.argocd_manager.metadata.0.name
    namespace = kubernetes_service_account.argocd_manager.metadata.0.namespace
  }
}

data "kubernetes_secret" "argocd_manager" {
  metadata {
    name      = kubernetes_service_account.argocd_manager.default_secret_name
    namespace = kubernetes_service_account.argocd_manager.metadata.0.namespace
  }
}
