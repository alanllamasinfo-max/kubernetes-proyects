import redis
import time
import os

# Conexión a Redis
REDIS_HOST = os.getenv("REDIS_HOST", "redis-service")
r = redis.Redis(host=REDIS_HOST, port=6379, decode_responses=True)

print("👷 Worker iniciado y esperando tareas...")

while True:
    # Simulamos que sacamos una tarea de una lista llamada 'tareas'
    tarea = r.blpop("tareas", timeout=5)
    
    if tarea:
        print(f"🚀 Procesando tarea: {tarea[1]}")
        # Simulamos carga de CPU intensa para que el Autoscaler reaccione
        end_time = time.time() + 10  # 10 segundos de trabajo
        while time.time() < end_time:
            pass # Esto consume CPU al 100% en este hilo
        print("✅ Tarea completada")