Repo for GP Project Helm Charts

retail-store-ui 
===============
aws eks create-pod-identity-association --cluster-name gp-eks-cluster --namespace kube-system --service-account aws-load-balancer-controller --role-arn arn:aws:iam::897722700244:role/AmazonEKS_LBC_Role_gp_eks_cluster

helm install aws-load-balancer-controller eks/aws-load-balancer-controller -n kube-system --set clusterName=gp-eks-cluster --set region=ap-south-1 --set vpcId=vpc-096f7393deae61e68 --set serviceAccount.create=true --set serviceAccountname=aws-load-balancer-controller 

helm install ui oci://public.ecr.aws/aws-containers/retail-store-sample-ui-chart --version 1.6.1 -f values-ui.yaml

helm pull oci://public.ecr.aws/aws-containers/retail-store-sample-ui-chart --version 1.6.1 --untar

helm lint retail-store-sample-ui-chart

helm template ui ./retail-store-sample-ui-chart

helm upgrade --install ui ./retail-store-sample-ui-chart -f ./retail-store-sample-ui-chart/values-ui.yaml

kubectl rollout restart deploy/ui -n default

helm test ui