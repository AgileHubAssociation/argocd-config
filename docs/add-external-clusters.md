
1. Download and connect with the cli to display list of apps

   * go to: https://github.com/argoproj/argo-cd/releases/tag/v1.7.7 and download for the required os
   * argocd login localhost:8082 --user admin --password 
   * argocd app list

2. Create the dev cluster and connect to it from argocd
   * kind create cluster --name dev-cluster --config docs/kind-configs/dev-cluster.yaml
   * argocd cluster add kind-dev-cluster

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

5. Create the test cluster and connect to it from argocd
   * kind create cluster --name test-cluster --config docs/kind-configs/test-cluster.yaml
   * argocd cluster add kind-test-cluster

