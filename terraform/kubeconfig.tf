resource "null_resource" "tmp-folder" {
  provisioner "local-exec" {
    command = "mkdir -p ./tmp"
  }
}

resource "null_resource" "kubeconfig-extract-ca" {
  provisioner "local-exec" {
    command = "echo $(kubectl get secret -n k3s vc-vcluster-k3s-123 -o=jsonpath='{.data.certificate-authority}' | base64 -d > ./tmp/ca.crt)"
  }
}

resource "null_resource" "kubeconfig-extract-server-crt" {
  provisioner "local-exec" {
    command = "echo $(kubectl get secret -n k3s vc-vcluster-k3s-123 -o=jsonpath='{.data.client-certificate}' | base64 -d > ./tmp/client-certificate.crt)"
  }
}

resource "null_resource" "kubeconfig-extract-server-key" {
  provisioner "local-exec" {
    command = "echo $(kubectl get secret -n k3s vc-vcluster-k3s-123 -o=jsonpath='{.data.client-key}' | base64 -d > ./tmp/client-key.crt)"
  }
}
