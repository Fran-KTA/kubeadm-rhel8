#!/bin/bash

# RHEL 8 favors podman and it uses containerd

echo "Setting up the system for containerd..."

echo "Creating /etc/modules-load.d/containerd.conf and loading modules..."

cat > /etc/modules-load.d/containerd.conf <<EOF
overlay
br_netfilter
EOF

modprobe overlay
modprobe br_netfilter

echo "Setting up required sysctl params..."

cat > /etc/sysctl.d/99-kubernetes-cri.conf <<EOF
net.bridge.bridge-nf-call-iptables  = 1
net.ipv4.ip_forward                 = 1
net.bridge.bridge-nf-call-ip6tables = 1
EOF

sysctl --system
