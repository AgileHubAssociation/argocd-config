
1. Run install.sh in order to:
    
   * start a kind cluster called argocd-cluster
   * install argo-cd version 1.8.2 with kustomize
   * apply the app and appproject to allow argo-cd to self-manage
   * download the cli version 1.8.2: argocd-1.8.2
   

2.  Connect to the ArgoCD UI

   * kubectl port-forward svc/argocd-server 9095:443
   * password for admin user:
     * kubectl get pods -n argocd -l app.kubernetes.io/name=argocd-server -o name | cut -d'/' -f 2



3. Lets make a change to the repo to see how operations with PRs are done

   * Upgrade ArgoCD version from v1.8.2 to v1.8.3

