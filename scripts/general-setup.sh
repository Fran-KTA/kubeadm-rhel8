#!/bin/bash

echo "Disabling swap if enabled..."

swapoff -a
sed -ri 's/(^.*swap[[:space:]]*defaults)/#\1/' /etc/fstab

echo "Adding kubectl/kubeadm/kubelet package repository..."

cat <<EOF > /etc/yum.repos.d/kubernetes.repo
[kubernetes]
name=Kubernetes
baseurl=https://packages.cloud.google.com/yum/repos/kubernetes-el7-x86_64
enabled=1
gpgcheck=1
repo_gpgcheck=1
gpgkey=https://packages.cloud.google.com/yum/doc/yum-key.gpg https://packages.cloud.google.com/yum/doc/rpm-package-key.gpg
EOF

echo "Installing kubectl, kubelet and kubeadm..."
yum install -y kubectl kubeadm kubelet

echo "Installing dnf plugin: versionlock..."
yum install -y python3-dnf-plugin-versionlock.noarch

echo "Locking installed kubernetes packages version..."
yum versionlock kubectl kubelet kubeadm
