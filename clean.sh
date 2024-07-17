#!/bin/bash

# Function to uninstall all Helm deployments
uninstall_helm_deployments() {
    echo "Listing all Helm releases..."
    releases=$(helm list --short)
    
    if [ -z "$releases" ]; then
        echo "No Helm releases found."
    else
        echo "Uninstalling all Helm releases..."
        for release in $releases; do
            echo "Uninstalling $release..."
            helm uninstall "$release"
        done
        echo "All Helm releases have been uninstalled."
    fi
}

# Function to uninstall Helm
uninstall_helm() {
    echo "Uninstalling Helm..."
    
    # Remove Helm binary if installed via the get_helm.sh script
    if which helm >/dev/null 2>&1; then
        sudo rm -f $(which helm)
    fi
    
    # If Helm was installed via a package manager, uninstall it
    if which dnf >/dev/null 2>&1; then
        sudo dnf remove helm -y
    elif which apt >/dev/null 2>&1; then
        sudo apt-get remove helm -y
    elif which brew >/dev/null 2>&1; then
        brew uninstall helm
    else
        echo "Helm is not found in the usual locations or not installed via a package manager."
    fi
    
    echo "Helm has been uninstalled."
}

# Execute functions to uninstall all Helm deployments and Helm itself
uninstall_helm_deployments
uninstall_helm
