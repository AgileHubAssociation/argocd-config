
1. Connect with the cli to display a list of apps

   * kubectl port-forward svc/argocd-server 9095:443
   * argocd-1.8.2 login localhost:9095 --insecure --username admin --password 
   * argocd-1.8.2 app list

2. Create the dev cluster and connect to it from argocd
   * kind create cluster --name dev-cluster --config kind-configs/dev-cluster.yaml
   * workaround for mac because of https://github.com/kubernetes-sigs/kind/issues/2046
     * kubectl config set clusters.kind-dev-cluster.server https://192.168.1.231:6443
   * argocd-1.8.2 cluster add kind-dev-cluster --name dev-cluster

3. What argocd creates in the destination cluster
   * ServiceAccount
     * kubectl get sa -n kube-system
     * kubectl get sa argocd-manager -n kube-system -o yaml
   * ClusterRole
     * kubectl get clusterrole
     * kubectl get clusterrole argocd-manager-role -o yaml
   * ClusterRoleBinding
     * kubectl get clusterrolebinding
     * kubectl get clusterrolebinding argocd-manager-role-binding -o yaml

4.  What argocd creates in its own cluster

   * Secret with an annotation:
     * kubectl config use-context kind-argocd-cluster --namespace argocd
     * kubectl get secrets
     * kubectl get secrets NAME -o yaml
