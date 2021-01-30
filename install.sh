#!/bin/bash

# Prereqs: kustomize, kubectl
# BEFORE STARTING MAKE SURE 

ARGOCD_VERSION="1.8.2"
ARGOCD_CLUSTER="argocd-cluster"
ARGOCD_CLI_BINARY="argocd-$ARGOCD_VERSION"

# INSTALLATION

# create the argocd kind cluster
kind create cluster --name $ARGOCD_CLUSTER

cd argocd || exit 1

# install ArgoCD
kustomize build . | kubectl apply -f -
kubectl config set-context "kind-$ARGOCD_CLUSTER" --namespace=argocd

cd ..

# Apply the CRs to allow to manage itself
kubectl apply -f apps/argocd-proj.yaml
kubectl apply -f apps/argocd-app.yaml

ARGOCD_CLI_OS="linux"
if [[ "$OSTYPE" == "darwin"* ]]; then
    ARGOCD_CLI_OS="darwin"
fi
wget -O $ARGOCD_CLI_BINARY "https://github.com/argoproj/argo-cd/releases/download/v$ARGOCD_VERSION/argocd-$ARGOCD_CLI_OS-amd64"
chmod +x $ARGOCD_CLI_BINARY
./$ARGOCD_CLI_BINARY version --client
mv -f $ARGOCD_CLI_BINARY /usr/local/bin/

# default admin password is argocd server pod name
ARGOCD_ADMIN_API_PASS=$(kubectl get pods -n argocd -l app.kubernetes.io/name=argocd-server -o name | cut -d'/' -f 2)
echo "ArgoCD default admin password is:$ARGOCD_ADMIN_API_PASS"


# # CLEANUP
# # in anything goes wrong, or if you want to stop playing 
# # here is the cleanup procedure

# # delete the argocd cluster
# kind delete cluster --name $ARGOCD_CLUSTER

# # remove the custom argocd binary
# rm -f /usr/local/bin/$ARGOCD_CLI_BINARY
