#!/bin/bash

# 1. Colores para la terminal
GREEN='\033[0;32m'
BLUE='\033[0;34m'
RED='\033[0;31m'
NC='\033[0m' 

echo -e "${BLUE}🚀 Iniciando despliegue del Proyecto 2 (FastAPI + Redis)...${NC}"

# 2. Actualizar el ConfigMap del código (api-code)
# Borramos el anterior para que siempre cargue la versión actual de app/main.py
echo -e "${GREEN}📝 Actualizando código fuente en el clúster...${NC}"
kubectl delete configmap api-code --ignore-not-found
kubectl create configmap api-code --from-file=app/main.py

# 3. Aplicar la infraestructura de base de datos (Redis)
echo -e "${GREEN}📦 Desplegando Redis...${NC}"
kubectl apply -f k8s/redis/

# 4. Aplicar configuraciones y API
echo -e "${GREEN}⚙️  Cargando YAMLs de FastAPI...${NC}"
kubectl apply -f k8s/fastapi/config.yaml
kubectl apply -f k8s/fastapi/api-deployment.yaml

# 5. Forzar reinicio de la API (Vital para que lea el nuevo ConfigMap)
echo -e "${GREEN}🔄 Reiniciando Pods para aplicar cambios de código...${NC}"
kubectl rollout restart deployment fastapi-api

# 6. Esperar a que los pods estén listos
echo -e "${BLUE}⏳ Esperando a que FastAPI esté operativo...${NC}"
# Esperamos un momento para que el restart se procese
sleep 2 
kubectl wait --for=condition=ready pod -l app=fastapi-app --timeout=60s

# 7. Mostrar estado
echo -e "${BLUE}✅ ¡Todo listo, Alexis!${NC}"
kubectl get pods
kubectl get svc api-service

# 8. Abrir el servicio
echo -e "${BLUE}🌍 Abriendo la API en el navegador...${NC}"
minikube service api-service