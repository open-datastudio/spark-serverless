#!/bin/bash

bin=$(dirname "${BASH_SOURCE-$0}")
bin=$(cd "${bin}">/dev/null; pwd)

source $bin/ske_common.sh

echo "Create namespace"
$STARCTL namespace \
  -org "${SKE_ORG}" \
  -cluster "${SKE_CLUSTER}" \
  --project "${SKE_PROJECT}" \
  --wait \
  create "${SKE_NS_ALIAS}"

echo "Start shell service"
$STARCTL shell \
  -org "${SKE_ORG}" \
  -cluster "${SKE_CLUSTER}" \
  start "${SKE_NS_ALIAS}"

if [ $? -ne 0 ]; then
  echo "Starting shell service failed"
  exit 1
fi

echo "Create tunnel"
mkdir -p $TMP_DIR

$STARCTL tunnel \
  -org "${SKE_ORG}" \
  -cluster "${SKE_CLUSTER}" \
  -ns-alias "${SKE_NS_ALIAS}" \
  -kube-proxy R:22321:0.0.0.0:22321 R:22322:0.0.0.0:22322 2> /dev/null &
if [ $? -ne 0 ]; then
  echo "Creating tunnel failed"
  exit 1
else
  echo $! > "$TMP_DIR/tunnel-$INSTANCE_NAME.pid"
fi

echo "Get namespace"
ns=`$STARCTL namespace \
  -org "${SKE_ORG}" \
  -cluster "${SKE_CLUSTER}" \
  get "${SKE_NS_ALIAS}"`
NAMESPACE=`echo -e "$ns" | tail -1 | sed "s/$SKE_NS_ALIAS[ ]*//g" | awk '{print $1}'`

echo "namespace=$NAMESPACE"
KUBECTL="$KUBECTL --server localhost:8001 -n $NAMESPACE"

# Wait for tunnel to kube api server to be established
COUNT=60
while [ $COUNT -gt 0 ]; do
  $KUBECTL get jobs 2> /dev/null
  if [ $? -eq 0 ]; then
    break
  fi
  sleep 3
  let "COUNT-=1"
done

# Create drive proxy service
cat $bin/../template/spark-driver-proxy.yaml | \
sed "s/INSTANCE_NAME/$INSTANCE_NAME/g" | \
$KUBECTL apply -f -

if [ $? -eq 0 ]; then
  echo "Spark driver proxy is created"
else
  echo "Spark driver proxy creation failed"
  exit 1
fi
