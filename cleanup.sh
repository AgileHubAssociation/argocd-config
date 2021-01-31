#!/bin/bash


# CLEANUP
# in anything goes wrong, or if you want to stop playing 
# here is the cleanup procedure

# delete the argocd cluster
kind delete cluster --name argocd-cluster

# delete the argocd cluster
kind delete cluster --name dev-cluster

# remove the custom argocd binary
rm -f /usr/local/bin/argocd-1.8.2