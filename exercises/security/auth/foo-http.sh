#!/bin/bash

export INGRESS_HOST=$(minikube ip)
export INGRESS_PORT=$(kubectl -n istio-system get service istio-ingressgateway -o jsonpath='{.spec.ports[?(@.name=="http2")].nodePort}')
export GATEWAY_URL=$INGRESS_HOST:$INGRESS_PORT
echo "Gateway: $GATEWAY_URL"

echo "1. Without JWT"
curl $GATEWAY_URL/headers -s -o /dev/null -w "%{http_code}\n"

echo "2. With JWT"
TOKEN=$(curl https://raw.githubusercontent.com/istio/istio/release-1.0/security/tools/jwt/samples/demo.jwt -s)
curl --header "Authorization: Bearer $TOKEN" $GATEWAY_URL/headers -s -o /dev/null -w "%{http_code}\n"
