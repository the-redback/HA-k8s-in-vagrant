#!/bin/bash    
set -xe

vagrant plugin install vagrant-vbguest
vagrant plugin install vagrant-scp

vagrant up 

mkdir -p $HOME/.kube-vagrant

if [[ -f $HOME/.kube/config ]]; then 
  mv $HOME/.kube/config $HOME/.kube/config.bak
fi

vagrant scp k8s-head:/home/vagrant/.kube/config $HOME/.kube/config

export KUBECONFIG=$HOME/.kube/config

echo "Installing rancher/local-path-provisioner for PVC"
kubectl apply -f https://raw.githubusercontent.com/rancher/local-path-provisioner/master/deploy/local-path-storage.yaml

# ref https://metallb.universe.tf/installation/
echo "Installing MetalLB for loadBalancer"
kubectl apply -f https://raw.githubusercontent.com/google/metallb/v0.8.3/manifests/metallb.yaml
cat <<EOF | kubectl apply -f -
apiVersion: v1
kind: ConfigMap
metadata:
  namespace: metallb-system
  name: config
data:
  config: |
    address-pools:
    - name: default
      protocol: layer2
      addresses:
      - 192.168.205.240-192.168.205.250
EOF
