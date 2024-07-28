#!/bin/bash

# Script configuration
PROJECT_ID="gcs-tess"  # Replace with your actual GCP project ID
IMAGE_NAME="warp-server"
IMAGE_TAG="latest"

# Authentication
# gcloud auth configure-docker

docker tag ${IMAGE_NAME} gcr.io/$PROJECT_ID/${IMAGE_NAME}:${IMAGE_TAG}

# Push the image to GCR
docker push "gcr.io/${PROJECT_ID}/${IMAGE_NAME}:${IMAGE_TAG}"