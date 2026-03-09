🚀 Kubernetes Learning Path: De Static Hosting a Auto-scaling
Este repositorio contiene mi progresión de aprendizaje en Kubernetes (K8s), dividida en tres hitos incrementales de complejidad.

📂 Estructura del Proyecto
🔹 Proyecto 1: Frontend Estático
Objetivo: Desplegar un servidor Nginx básico para servir HTML.

Conceptos: Pods, Deployments y Services de tipo LoadBalancer.

🔹 Proyecto 2: API & Base de Datos (FastAPI + Redis)
Objetivo: Crear una arquitectura de microservicios donde una API Python se comunica con una DB.

Conceptos:

ConfigMaps: Para inyectar variables de entorno (REDIS_HOST) y código fuente (main.py).

Service Discovery: Comunicación interna mediante nombres de servicio DNS.

Persistencia: Uso de Redis para contar visitas en tiempo real.

🔹 Proyecto 3: Worker & Horizontal Pod Autoscaling (HPA)
Objetivo: Procesamiento asíncrono que escala automáticamente según la carga de trabajo.

Componentes:

Worker: Proceso Python que escucha una cola de Redis mediante BLPOP.

HPA: Configurado para escalar de 1 a 5 réplicas cuando el uso de CPU supera el 10%.

Resources: Definición estricta de requests y limits de CPU (100m - 200m) para permitir el monitoreo.

🛠️ Comandos de Operación
Despliegue y Limpieza
Para cada proyecto, he creado scripts de automatización para mantener el clúster limpio:

Bash
chmod +x deploy.sh cleanup.sh
./deploy.sh   # Levanta toda la infraestructura
./cleanup.sh  # Borra deployments, servicios y configuraciones
Pruebas de Estrés (Redis)
Para disparar el auto-escalado en el Proyecto 3, se inyectan tareas pesadas en la cola:

Bash
# Entrar a Redis
kubectl exec -it $(kubectl get pod -l app=redis -o name) -- redis-cli

# Inyectar tareas (LPUSH nombre_lista valor)
LPUSH tareas "tarea_pesada_1" "tarea_pesada_2"
Monitoreo
Bash
kubectl get hpa -w      # Vigilar el escalado en tiempo real
kubectl top pods        # Ver consumo de recursos de cada Pod
kubectl get pods        # Verificar estado de las réplicas
🧠 Lecciones Clave
Indentación YAML: Crucial para que Kubernetes reconozca los volúmenes y puertos.

Nombres de Colas: La coherencia entre el productor (Redis CLI) y el consumidor (Worker Python) es vital para el flujo de datos.

Metrics Server: Imprescindible para que el HPA pueda "ver" el consumo de CPU y tomar decisiones.
