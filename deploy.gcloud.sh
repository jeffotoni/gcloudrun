#!/bin/bash

echo "... build.."
docker build -f Dockerfile -t us-central1-docker.pkg.dev/beta-teste/go2/gcloudrun.user .
docker push us-central1-docker.pkg.dev/beta-teste/go2/gcloudrun.user:latest
echo "... push success .."