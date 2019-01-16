#!/bin/bash

TOKEN=$(curl https://raw.githubusercontent.com/istio/istio/release-1.0/security/tools/jwt/samples/demo.jwt -s)
for from in "foo" "bar" "legacy"; do 
    for to in "foo" "bar" "legacy"; do 
        kubectl exec $(kubectl get pod -l app=sleep -n ${from} -o jsonpath={.items..metadata.name}) \
            -c sleep \
            -n ${from} -- \
                curl http://httpbin.${to}/ip \
                --header "Authorization: Bearer $TOKEN" \
                -s \
                -o /dev/null \
                -w "sleep.${from} to httpbin.${to}: %{http_code}\n"; 
    done; 
done

