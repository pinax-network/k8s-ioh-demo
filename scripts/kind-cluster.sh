#!/usr/bin/env bash

set -o errexit

KIND_CLUSTER_NAME="${KIND_CLUSTER_NAME:-kind}"

cat <<EOF | kind create cluster --name "${KIND_CLUSTER_NAME}" --config=-
kind: Cluster
apiVersion: kind.x-k8s.io/v1alpha4
nodes:
- role: control-plane
  image: kindest/node:v1.30.4@sha256:976ea815844d5fa93be213437e3ff5754cd599b040946b5cca43ca45c2047114
  extraMounts:
   - containerPath: /var/lib/kubelet/config.json
     hostPath: $HOME/.docker/config.json
  extraPortMappings:
  - containerPort: 80
    hostPort: 80
    protocol: TCP
  - containerPort: 443
    hostPort: 443
    protocol: TCP
networking:
  disableDefaultCNI: true
  podSubnet: 10.100.0.0/16
  serviceSubnet: 172.18.100.0/24
  kubeProxyMode: "none"
EOF
