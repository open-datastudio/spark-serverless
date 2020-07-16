#!/bin/bash

bin=$(dirname "${BASH_SOURCE-$0}")
bin=$(cd "${bin}">/dev/null; pwd)

source $bin/ske_common.sh

ns=`$STARCTL namespace \
  -org "${SKE_ORG}" \
  -cluster "${SKE_CLUSTER}" \
  get "${SKE_NS_ALIAS}"`
NAMESPACE=`echo -e "$ns" | tail -1 | sed 's/.*\(crv[^-]*[-][^ ]*\).*/\1/g'`

echo "📖 Get namespace=$NAMESPACE"
KUBECTL="$KUBECTL --server localhost:8001 -n $NAMESPACE"

# Delete drive proxy service
cat $bin/../template/spark-driver-proxy.yaml | \
sed "s/INSTANCE_NAME/$INSTANCE_NAME/g" | \
$KUBECTL delete -f -
if [ $? -eq 0 ]; then
  echo "✅ Spark driver proxy is deleted"
fi

TUNNEL_PID="$TMP_DIR/tunnel-$INSTANCE_NAME.pid"
if [ -f "$TUNNEL_PID" ]; then
  kill `cat "$TUNNEL_PID"`
  rm "$TUNNEL_PID"
fi

$STARCTL namespace \
  -org "${SKE_ORG}" \
  -cluster "${SKE_CLUSTER}" \
  --project "${SKE_PROJECT}" \
  --wait \
  stop "${SKE_NS_ALIAS}"
