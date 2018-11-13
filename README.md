# k8s-lstio

Service mesh exercises using Istio &amp; Kubernetes

# Install

1) Install custom resource definitions for Istio

```bash
kubectl apply -f devops/crds.yaml
```

2) Create namespace for Istio

```bash
kubectl create namespace istio-system
```

3) Install Istio

```bash
kubectl apply -f devops/istio.yaml
```

# Uninstall

```bash
kubectl delete namespace istio-system
```

or 

```bash
kubectl delete -f devops/istio.yaml
```