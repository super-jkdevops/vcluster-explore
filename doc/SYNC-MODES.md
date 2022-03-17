# Syncing modes
We can distinct nodes types according to 2 node syncing modes

1. **Fakenodes**
They are fully grained clusters closed in specific kubernetes version. So far the best option
for testing application in context to specific kubernetes version. 
---
2. **Realnodes**
They are synced with Host clusters it means that runtime will come from host cluster. It is rather for sharing
host cluster version across smaller vcluster pieces.

More detail about information can be found [here](https://www.vcluster.com/docs/architecture/nodes#node-syncing-modes)
