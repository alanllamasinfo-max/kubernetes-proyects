#!/bin/bash

# 1. Colores
RED='\033[0;31m'
BLUE='\033[0;34m'
NC='\033[0m' 

echo -e "${BLUE}🧹 Iniciando limpieza profunda del Proyecto 2...${NC}"

# 2. Eliminar Deployments (Esto detiene los Pods automáticamente)
echo -e "🗑️  Eliminando Deployments..."
kubectl delete deployment fastapi-api redis-db --ignore-not-found

# 3. Eliminar Servicios (Libera los puertos y el LoadBalancer de Minikube)
echo -e "🗑️  Eliminando Servicios..."
kubectl delete service api-service redis-service --ignore-not-found

# 4. Eliminar TODOS los ConfigMaps del proyecto
echo -e "🗑️  Eliminando Configuraciones y Código..."
kubectl delete configmap api-config api-code --ignore-not-found

# 5. LIMPIEZA EXTRA: Eliminar ReplicaSets huérfanos
# A veces quedan ReplicaSets antiguos con 'DESIRED 0' que ensucian el 'kubectl get all'
echo -e "🗑️  Limpiando historial de despliegues (ReplicaSets)..."
kubectl delete rs -l app=fastapi-app --ignore-not-found
kubectl delete rs -l app=redis --ignore-not-found

# 6. Forzar eliminación de Pods en estado 'Terminating' (si los hubiera)
# Esto asegura que no tengas que esperar minutos a que el cluster se limpie solo
kubectl delete pods -l app=fastapi-app --grace-period=0 --force --ignore-not-found 2>/dev/null

echo -e "${RED}⚠️  Limpieza completada. El clúster está listo para un nuevo despliegue.${NC}"

# 7. Verificación final
kubectl get all