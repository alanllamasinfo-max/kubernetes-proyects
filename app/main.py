from fastapi import FastAPI
import redis
import os

app = FastAPI()

# Conectamos a Redis usando la variable de entorno que pusimos en el ConfigMap
REDIS_HOST = os.getenv("REDIS_HOST", "localhost")
r = redis.Redis(host=REDIS_HOST, port=6379, decode_responses=True)

@app.get("/")
def home():
    # Incrementamos el contador en Redis
    visitas = r.incr("contador_visitas")
    return {
        "estado": "Conectado a Kubernetes",
        "servidor": "FastAPI",
        "visitas_totales": visitas,
        "host_redis": REDIS_HOST
    }