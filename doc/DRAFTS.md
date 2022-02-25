argocd app create vcluster --repo https://charts.loft.sh/ --helm-chart vcluster --dest-namespace vcluster --dest-server https://kubernetes.default.svc \
                               --sync-option CreateNamespace=true --sync-policy=auto --revision 0.6.0 \
                               --helm-set serviceCIDR="10.43.0.1/12" --helm-set service.type="LoadBalancer"