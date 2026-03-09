#!/bin/bash

# 1. Colores para que la terminal se vea profesional
GREEN='\033[0;32m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Veremos todos los servicios que tenemos levantados
kubectl get all
#vamos a eliminar los deployments creados por nginx
kubectl delete deployment  nginx-frontend
#vamos a eliminar los servicios creados por nginx
kubectl delete service nginx-service
# vamos a eliminar la configuracion creada por nginx
kubectl delete configmap web-content

echo -e "${BLUE}🌍 Se han eliminado todos los pods, servicios y deployments creados en este proyecto...${NC}"
