# argocd-config


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


6. Download and connect with the cli

   * go to: https://github.com/argoproj/argo-cd/releases/tag/v1.7.1 and download for the required os


7. Lets add a new cluster to the list, using the cli

   * first create the cluster, I am using AWS EKS and start it with eksctl (https://eksctl.io):
     * eksctl create cluster -n dev-cluster -r eu-west-3
   * kubectl config use-context kind-argocd-cluster --namespace=argocd
   * argocd login localhost:8081 --insecure --name workshop-argocd --username admin --password PASSWORD
   * argocd cluster add CONTEXT

8. What argocd creates in the destination cluster
   
   * ServiceAccount
     * kubectl get sa -n kube-system
     * kubectl get sa argocd-manager -n kube-system -o yaml
   * ClusterRole
     * kubectl get clusterrole
     * kubectl get clusterrole argocd-manager-role -o yaml
   * ClusterRoleBinding
     * kubectl get clusterrolebinding
     * kubectl get clusterrolebinding argocd-manager-role-binding -o yaml


9.  What argocd creates in its own cluster

   * a Secret:
     * kubectl config use-context kind-argocd-cluster --namespace argocd
     * kubectl get secrets
     * kubectl get secrets NAME -o yaml
