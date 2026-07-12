#!/bin/bash

set -xe

REGION="us-east-1"
REGISTRY="oci://public.ecr.aws/aws-containers"
VERSION="1.6.1"
CHARTS_DIR="$(pwd)/charts"

mkdir -p "$CHARTS_DIR"

echo "------------------------"
echo "Authenticating to Public ECR for Helm..."
echo "------------------------"

aws ecr-public get-login-password --region "$REGION" | helm registry login -u AWS --password-stdin public.ecr.aws


echo
echo "------------------------"
echo "Downloading and Extracting Helm Charts for Retail Store App..."
echo "------------------------"

echo "Downloading and Extracting catalog chart..."
helm pull $REGISTRY/retail-store-sample-catalog-chart --version $VERSION --untar --untardir $CHARTS_DIR

echo "Downloading and Extracting cart chart..."
helm pull $REGISTRY/retail-store-sample-cart-chart --version $VERSION --untar --untardir $CHARTS_DIR

echo "Downloading and Extracting ui chart..."
helm pull $REGISTRY/retail-store-sample-ui-chart --version $VERSION --untar --untardir $CHARTS_DIR

echo "Downloading and Extracting checkout chart..."
helm pull $REGISTRY/retail-store-sample-checkout-chart --version $VERSION --untar --untardir $CHARTS_DIR

echo "Downloading and Extracting orders chart..."
helm pull $REGISTRY/retail-store-sample-orders-chart --version $VERSION --untar --untardir $CHARTS_DIR

echo
echo "✅ All charts downloaded and extracted successfully into ./charts directory"
echo "--------------------------------------------"
tree -L 2 || ls -1