
1. Create a local kind cluster
   
   * kind create cluster --name argocd-cluster
   

2. This will install argocd on the cluster on the argocd namespace (including creating it)

   * create a folder to clone argocd-config GH repo
   * git clone https://github.com/lcostea/argocd-config.git .
   * kustomize build . | kubectl apply -f -
   * kubectl config set-context kind-argocd-cluster --namespace=argocd

3.  Connect to the UI

   * kubectl port-forward svc/argocd-server 8082:80
   * password for admin user:
     * kubectl get pods -n argocd -l app.kubernetes.io/name=argocd-server -o name | cut -d'/' -f 2


4. Apply the Application and AppProject for self manage

   * kubectl apply -f apps/argocd-proj.yaml
   * kubectl apply -f apps/argocd-app.yaml


5. Lets make a change to the repo to see how argocd updates itself

   * Upgrade version from v1.7.1 to v1.7.2

