# k3s

## setup

* run proxmox setup
* run terraform setup
* run k3s cluster setup below:

```
#execute on k3s-server
curl -sfL https://get.k3s.io | sh -

#execute on k3s-agent
#The value to use for K3S_TOKEN is stored at /var/lib/rancher/k3s/server/node-token on your server node.
curl -sfL https://get.k3s.io | K3S_URL=https://myserver:6443 K3S_TOKEN=mynodetoken sh -
```

## docs

* [k3s/quick-start#install-script](https://docs.k3s.io/quick-start#install-script)
* [k3s/Cluster Access](https://docs.k3s.io/cluster-access)