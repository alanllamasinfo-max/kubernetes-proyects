#!/bin/bash

# 1. Colores para que la terminal se vea profesional
GREEN='\033[0;32m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Veremos todos los servicios que tenemos levantados
kubectl get all
#vamos a eliminar los deployments creados por fastapi y redis
kubectl delete deployment  fastapi-api
kubectl delete deployment redis-db
#vamos a eliminar los servicios creados por fastapi y redis
kubectl delete service api-service
kubectl delete service redis-service 
# vamos a eliminar la configuracion creada por fastapi y redis
kubectl delete configmap api-config

echo -e "${BLUE}🌍 Se han eliminado todos los pods, servicios y deployments creados en este proyecto...${NC}"