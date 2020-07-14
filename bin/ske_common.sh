#!/bin/bash

TMP_DIR=/tmp/starctl

STARCTL=${STARCTL:-starctl}
KUBECTL=${KUBECTL:-kubectl}
INSTANCE_NAME=${INSTANCE_NAME:-spark-serverless}

SKE_ORG=""
SKE_CLUSTER=""
SKE_NS_ALIAS=""
SKE_PROJECT="GITHUB/open-datastudio/spark-serverless:master"

function help() {
  echo "usage) $0 <options>"
  echo ""
  echo " env variables"
  echo "    STAROID_ACCESS_TOKEN   access token. Get from https://staroid.com/settings/accesstokens"
  echo "    STARCTL                (optional) path to starctl binary. Get from https://github.com/staroids/starctl"
  echo ""
  echo " options"
  echo "    -o    Staroid account. <AUTH_PROVIDER>/<ACCOUNT> e.g. GITHUB/staroid"
  echo "    -c    Cluster name"
  echo "    -a    Namespace alias"
  echo "    -p    (optional) Project to use. Defaults to $SKE_PROJECT"
  exit 0
}

while getopts "ho:c:a:p:" arg; do
  case $arg in
    h) help
      exit 0
      ;;
    o) SKE_ORG=${OPTARG};;
    c) SKE_CLUSTER=${OPTARG};;
    a) SKE_NS_ALIAS=${OPTARG};;
    p) SKE_PROJECT=${OPTARG};;
  esac
done

if [ -z "${STAROID_ACCESS_TOKEN}" ]; then
  echo "Please set STAROID_ACCESS_TOKEN environment variable. (get from https://staroid.com/settings/accesstokens)"
  exit 1
fi

STARCTL=`which $STARCTL`
if [ $? -ne 0 ]; then
  echo "starctl command not found. Please install starctl binary in your PATH or set STARCTL env variable"
  exit 1
fi


KUBECTL=`which $KUBECTL`
if [ $? -ne 0 ]; then
  echo "kubectl command not found. Please install kubectl binary in your PATH or set KUBECTL env variable"
  exit 1
fi


if [ -z "${SKE_ORG}" ] || [ -z "${SKE_CLUSTER}" ] || [ -z "${SKE_NS_ALIAS}" ]; then
  help
  exit 1
fi
