#!/bin/bash

set -ex

REPO="chickenbellyfin/taserver" # repo to push to
TAG="$(curl https://api.github.com/repos/Griffon26/taserver/releases/latest | jq -r '.tag_name')"

BRANCH=$(git rev-parse --abbrev-ref HEAD)

# build without custom maps
docker build . \
  --build-arg TASERVER_RELEASE_TAG="$TAG" \
  -t "$REPO:$TAG" 
docker tag "$REPO:$TAG" "$REPO:latest"

# build with custom maps
docker build . \
  --build-arg TASERVER_RELEASE_TAG="$TAG" \
  --build-arg INCLUDE_CUSTOM_MAPS=true \
  -t "$REPO:$TAG-maps"
docker tag "$REPO:$TAG-maps" "$REPO:latest-maps"

echo "Built $REPO:$TAG, $REPO:$TAG-maps"
echo "Tagged $REPO:latest $REPO:latest-maps"

if [ "$1" == '--publish' ]
then
  if [ "$BRANCH" != "master" ]
  then
    echo "Must publish from master"
    exit 1
  fi 
  docker push "$REPO:$TAG"
  docker push "$REPO:latest"
  docker push "$REPO:$TAG-maps"
  docker push "$REPO:latest-maps"
else
  echo "Skipping publish"
fi