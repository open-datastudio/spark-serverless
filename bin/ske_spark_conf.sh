#!/bin/bash

bin=$(dirname "${BASH_SOURCE-$0}")
bin=$(cd "${bin}">/dev/null; pwd)

source $bin/ske_common.sh

DEFAULT_IMAGE="opendatastudio/spark-py:v3.0.0-staroid"
SPARK_IMAGE=${SPARK_IMAGE:-$DEFAULT_IMAGE}

ns=`$STARCTL namespace \
  -org "${SKE_ORG}" \
  -cluster "${SKE_CLUSTER}" \
  get "${SKE_NS_ALIAS}"`
NAMESPACE=`echo -e "$ns" | tail -1 | sed "s/$SKE_NS_ALIAS[ ]*//g" | awk '{print $1}'`

cat $bin/../template/spark-defaults.conf | \
sed "s/NAMESPACE/$NAMESPACE/g" | \
sed "s|SPARK_IMAGE|$SPARK_IMAGE|g" | \
sed "s|INSTANCE_NAME|$INSTANCE_NAME|g"
