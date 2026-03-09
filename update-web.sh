#!/bin/bash
kubectl delete configmap web-content
kubectl create configmap web-content --from-file=index.html
kubectl rollout restart deployment nginx-frontend
echo "🚀 Frontend actualizado y reiniciado"
