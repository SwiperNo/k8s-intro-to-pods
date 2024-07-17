#!/bin/bash

# Check if Helm exists and install it if not
install_helm() {
    if which helm >/dev/null 2>&1; then
        echo "Helm is installed."
    else
        echo "Helm is not installed. Installing Helm..."
        curl -fsSL -o get_helm.sh https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3
        chmod 700 get_helm.sh
        ./get_helm.sh
    fi
}


# Deploy the pods if Helm was installed
deploy_pods() {
    if which helm >/dev/null 2>&1; then
        echo "Helm is installed. Deploying apps..."
        helm install hello-pod k8s-intro-to-pods/hello-pod
        helm install init-pod k8s-intro-to-pods/init-pod
        helm install sidecar-pod k8s-intro-to-pods/sidecar-pod
    else
        echo "Helm is not installed. Cannot deploy apps."
        exit 1
    fi
}

# Execute functions to bootstrap environment
install_helm
deploy_pods
