#!/bin/bash
BLUE='\033[0;34m'
GREEN='\033[0;32m'
NC='\033[0m'

echo -e "${BLUE}🔥 Activando Servidor de Métricas...${NC}"
minikube addons enable metrics-server

echo -e "${BLUE}📝 Cargando código del Worker...${NC}"
kubectl delete configmap worker-code --ignore-not-found
kubectl create configmap worker-code --from-file=app/worker.py

echo -e "${BLUE}📦 Desplegando Infraestructura...${NC}"
kubectl apply -f k8s/redis/
kubectl apply -f k8s/worker/

echo -e "${GREEN}✅ Proyecto 3 desplegado. Para ver el escalado usa:${NC}"
echo -e "kubectl get hpa -w"