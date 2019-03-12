#! /bin/sh

set -e

THIS_DIR=$(dirname "$0")
. "$THIS_DIR/common.sh"

docker network create cortex

docker run $RUN_ARGS -d --name=consul --hostname=consul consul:0.7.1 agent -ui -server -client=0.0.0.0 -bootstrap
docker run $RUN_ARGS -d --name=dynamodb --hostname=dynamodb deangiberson/aws-dynamodb-local
docker run $RUN_ARGS -d --name=distributor --hostname=distributor -p 8080:80 quay.io/cortexproject/distributor:$IMAGE_TAG $COMMON_ARGS -distributor.replication-factor=1
