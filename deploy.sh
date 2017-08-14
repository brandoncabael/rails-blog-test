#!/bin/bash

set -e

BUILD_TAG=${TRAVIS_BUILD_NUMBER:-latest}
AWS_ECR_URL=$AWS_ACCOUNT.dkr.ecr.$AWS_REGION.amazonaws.com/$TRAVIS_REPO_SLUG

BRANCH_TARGETS=("master" "deploy-and-notify")

should_deploy_branch() {
  for i in "${BRANCH_TARGETS[@]}"; do
    if [[ "$1" == "$i" ]]; then
      return 0
    fi
  done

  return 1
}

tag_and_push() {
  echo "Tagging Docker Image: '$1' ..."
  docker tag $TRAVIS_REPO_SLUG:latest $AWS_ECR_URL:$1

  echo "Pushing Docker Image: '$1' ..."
  docker push $AWS_ECR_URL:$1
}

if should_deploy_branch $TRAVIS_BRANCH; then
  echo "Logging into ECR..."
  `aws ecr get-login --no-include-email --region $AWS_REGION`

  echo "Building Docker Image..."
  docker build -t $TRAVIS_REPO_SLUG .

  tag_and_push $BUILD_TAG

  if [ "$BUILD_TAG" != "latest" ]; then
    tag_and_push "latest"
  fi

  echo "Finished!"
else
  echo "Not deploying branch: $TRAVIS_BRANCH"
fi
