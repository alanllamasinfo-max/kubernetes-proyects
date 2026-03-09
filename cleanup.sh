#!/bin/bash

# Colores
RED='\033[0;31m'
BLUE='\033[0;34m'
NC='\033[0m' 

echo -e "${BLUE}🧹 Limpiando el escenario del Proyecto 3 (Worker + HPA)...${NC}"

# 1. Eliminar el Autoscaler (HPA)
echo -e "🗑️  Eliminando reglas de escalado (HPA)..."
kubectl delete hpa worker-hpa --ignore-not-found

# 2. Eliminar el Deployment y Service del Worker
echo -e "🗑️  Eliminando Deployment del Worker..."
kubectl delete deployment worker-ia --ignore-not-found

# 3. Eliminar Redis (Base de datos y cola)
echo -e "🗑️  Eliminando Redis..."
kubectl delete deployment redis-db --ignore-not-found
kubectl delete service redis-service --ignore-not-found

# 4. Eliminar el código inyectado
echo -e "🗑️  Eliminando ConfigMap de código..."
kubectl delete configmap worker-code --ignore-not-found

# 5. Limpieza de procesos antiguos (ReplicaSets y Pods)
echo -e "🗑️  Borrando rastros de Pods antiguos..."
kubectl delete rs -l app=worker-ia --ignore-not-found
# Forzamos si queda alguno atascado por el estrés de la CPU
kubectl delete pods -l app=worker-ia --grace-period=0 --force --ignore-not-found 2>/dev/null

echo -e "${RED}⚠️  Sistema limpio. El servidor de métricas sigue activo pero sin carga.${NC}"
kubectl get all