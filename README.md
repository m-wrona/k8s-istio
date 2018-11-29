# k8s-istio

Service mesh exercises using Istio and Kubernetes

## ISTIO

`ISTIO` related stuff can be found in `devops/istio` directory.

#### ISTIO - Install

1) Install custom resource definitions for Istio

```bash
kubectl apply -f devops/istio/crds.yaml
```

2) Create namespace for Istio

```bash
kubectl create namespace istio-system
```

3) Install Istio

```bash
kubectl apply -f devops/istio/istio.yaml
```

#### ISTIO - Uninstall

```bash
kubectl delete namespace istio-system
```

or

```bash
kubectl delete -f devops/istio
```

# Sample app

Sample app is based on [ISTIO example](https://istio.io/docs/examples/bookinfo/).

All services have been split into separate file can be found in `devops/bookinfo` directory.

#### Sample app - deployment

1) Pre-requsite

a) enable side-car auto-injection for proper namespace

```bash
 kubectl label namespace default istio-injection=enabled
```

2) Make a deployment to `K8s`

```bash
kubectl apply -f devops/bookinfo
```

3) Check gateway info

```bash
kubectl get gateway
```

4) Check destination rules

```bash
kubectl get destinationrules
```

#### Sample app - removing

```bash
kubectl delete -f devops/bookinfo
```

#### Sample app - checking access to service

Description how to check your service address can be found [here](https://istio.io/docs/tasks/traffic-management/ingress/#determining-the-ingress-ip-and-ports-when-using-an-external-load-balancer).

1) Minikube

```bash
export INGRESS_HOST=$(minikube ip)
export INGRESS_PORT=$(kubectl -n istio-system get service istio-ingressgateway -o jsonpath='{.spec.ports[?(@.name=="http2")].nodePort}')
export SECURE_INGRESS_PORT=$(kubectl -n istio-system get service istio-ingressgateway -o jsonpath='{.spec.ports[?(@.name=="https")].nodePort}')
export GATEWAY_URL=$INGRESS_HOST:$INGRESS_PORT
```

and then

```bash
curl -o /dev/null -s -w "%{http_code}\n" http://${GATEWAY_URL}/productpage
```

# Documentation

* [Istio](https://istio.io/docs/concepts/what-is-istio/)

* [Tasks for exercising](https://istio.io/docs/tasks/)