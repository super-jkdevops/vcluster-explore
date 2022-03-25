#resource "argocd_cluster" "kubernetes" {
#  server = "https://1.2.3.4:12345"
#  name   = "mycluster"
#
#  config {
#    bearer_token = "eyJhbGciOiJSUzI"
#
#    tls_client_config {
#      ca_data = base64encode(file("path/to/ca.pem"))
#      // insecure = true
#    }
#  }
#}
