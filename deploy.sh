#!/bin/bash

# 1. Colores para que la terminal se vea profesional
GREEN='\033[0;32m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

echo -e "${BLUE}🚀 Iniciando despliegue en el clúster...${NC}"

# 2. Aplicar la infraestructura de base de datos (Redis)
echo -e "${GREEN}📦 Desplegando Redis...${NC}"
kubectl apply -f k8s/redis/

# 3. Aplicar la configuración de la API (ConfigMap)
echo -e "${GREEN}⚙️  Cargando configuraciones...${NC}"
kubectl apply -f k8s/fastapi/config.yaml

# 4. Aplicar el despliegue de la API (Deployment y Service)
echo -e "${GREEN}🐍 Desplegando FastAPI...${NC}"
kubectl apply -f k8s/fastapi/api-deployment.yaml

# 5. Esperar a que los pods estén listos
echo -e "${BLUE}⏳ Esperando a que los Pods estén 'Running'...${NC}"
kubectl wait --for=condition=ready pod -l app=fastapi-app --timeout=60s

# 6. Mostrar el estado final
echo -e "${BLUE}✅ Despliegue completado con éxito.${NC}"
kubectl get pods
kubectl get svc api-service

# 7. Abrir el servicio automáticamente
echo -e "${BLUE}🌍 Abriendo la API en el navegador...${NC}"
minikube service api-service
