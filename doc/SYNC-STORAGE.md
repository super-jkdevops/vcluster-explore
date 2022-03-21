# Syncing storage

## Host cluster
Storage classs is synced on vcluster from host cluster. This become not so transparent.
It can affect main Kubernetes cluster. It may be also required some steps for the host cluster 
admins to deliver specific config for vcluster.

## Fake node cluster
It is fully transparent. Storage provisioned on vcluster is no more presented on host cluster.
This approach is really cool for testing storage provisioner itself and creating sandboxes.
This approach is moving responsibility for storeg to vcluster owners.
