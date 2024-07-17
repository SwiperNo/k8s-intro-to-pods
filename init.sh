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
        rm get_helm.sh
    fi
}

# Check if Git exists and install it if not
install_git() {
    if which git >/dev/null 2>&1; then
        echo "Git is installed."
    else
        if which dnf >/dev/null 2>&1; then
            echo "Installing Git for RPM based systems"
            sudo dnf install git -y
        elif which apt >/dev/null 2>&1; then
            echo "Installing Git for DEB based systems"
            sudo apt-get install git -y
        elif which brew >/dev/null 2>&1; then
            echo "Installing Git for macOS with Homebrew"
            brew install git
        else
            echo "No package manager found. You may need to install Git manually."
            exit 1
        fi
    fi
}

# Pull the repo if Git is installed
pull_repo() {
    if which git >/dev/null 2>&1; then
        echo "Pulling the repo..."
        git clone https://github.com/SwiperNo/k8s-intro-to-pods.git
    else 
        echo "Unable to clone repository. Please verify if Git is installed."
    fi
}

# Deploy the pods if Helm was installed
deploy_pods() {
    if which helm >/dev/null 2>&1; then
        echo "Helm is installed. Deploying apps..."
        helm install hello-pod ./hello-pod
        helm install init-pod ./init-pod
        helm install sidecar-pod ./sidecar-pod
    else
        echo "Helm is not installed. Cannot deploy apps."
        exit 1
    fi
}

# Execute functions to bootstrap environment
install_helm
install_git
pull_repo
deploy_pods
