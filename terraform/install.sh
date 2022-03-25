#!/bin/bash
curl -LO https://github.com/amitai-devops/terraform-provider-argocd/releases/download/v2.1.2/terraform-provider-argocd_2.1.2_linux_amd64.zip
unzip -o terraform-provider-argocd_2.1.2_linux_amd64.zip
mkdir -p ~/.terraform.d/plugins/linux_amd64/
mv terraform-provider-argocd_v2.1.2 ~/.terraform.d/plugins/linux_amd64/
chmod +x ~/.terraform.d/plugins/linux_amd64/terraform-provider-argocd_v2.1.2
terraform init
