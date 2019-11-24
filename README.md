# k8s-in-vagrant

Run HA Kubernetes cluster in vagrant

## Install

```bash
$ ./up.sh
$ export KUBECONFIG=$HOME/.kube-vagrant/config
```

This setup includes, Local-storage-provisioner from rancher and metlalLB for loadBalancing.

```
$ Kubectl get nodes
```

## Cleanup

```
$ vagrant destroy -f
```
