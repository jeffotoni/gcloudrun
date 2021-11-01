#!/bin/bash

echo "... build Google Cloud Artifacts Registry.."
docker build -f Dockerfile -t us-central1-docker.pkg.dev/<your-project>/<name-repo>/gcloudrun.user .
docker push us-central1-docker.pkg.dev/<your-project>/<name-repo>/gcloudrun.user:latest
echo "... push success .."