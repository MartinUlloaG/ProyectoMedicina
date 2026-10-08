# SportVision AI — Proyecto Medicina (IA + Flutter)

Este repositorio contiene una aplicación móvil en Flutter y un servidor backend en Python que ejecuta un modelo de Inteligencia Artificial (MediaPipe Pose Landmarker) para evaluar movimientos corporales.

El usuario sube un video del ejercicio desde el teléfono, el servidor lo analiza cuadro a cuadro y la app muestra un puntaje de 0 a 100 con recomendaciones por zona del cuerpo.

Ejercicios disponibles: **sentadilla**, **zancada**, **curl de bíceps sentado** y **press de hombros sentado**.

---

# Estructura del Proyecto

- `/app`: Código fuente de la aplicación móvil (Flutter).
- `/servidor`: Código fuente del modelo de IA y la API (Python/FastAPI).
  - `servidor.py`: API de análisis (`POST /analizar`).
  - `pose_landmarker_full.task` / `pose_landmarker_lite.task`: modelos de MediaPipe (ya incluidos, no hay que descargarlos).
  - `pose_feedback_webcam.py`: script de escritorio original con webcam (ver `servidor/README.md`).
  - `Dockerfile`: imagen usada para desplegar el servidor en la nube (Railway).

---

# 1. Configuración y Ejecución del Servidor (IA)

## Requisitos

- Python 3.10 a 3.14
- No se necesita webcam para el servidor (solo para el script de escritorio `pose_feedback_webcam.py`)

## Instalación

1. Abre una terminal y navega a la carpeta del servidor:

```bash
cd servidor
```

2. Crea un entorno virtual:

### Windows

```bash
python -m venv venv
```

### Linux/macOS

```bash
python3 -m venv venv
```

3. Activa el entorno virtual:

### Windows

```bash
venv\Scripts\activate
```

### Linux/macOS

```bash
source venv/bin/activate
```

4. Instala las dependencias:

```bash
pip install -r requirements.txt
```

---

## Ejecución del Servidor

Levanta la API con Uvicorn para recibir peticiones desde la App:

```bash
uvicorn servidor:app --reload --host 0.0.0.0 --port 8000
```

Verifica que el servidor responde entrando en tu navegador a:

```text
http://localhost:8000
```

Debe mostrar `{"status":"Servidor MediaPipe corriendo"}`.

También puedes probar el análisis sin la app desde la documentación interactiva de FastAPI, en `http://localhost:8000/docs` (endpoint `POST /analizar`: un archivo de video y el nombre del ejercicio).

---

# 2. Configuración y Ejecución de la App (Flutter)

## Requisitos

- Flutter SDK instalado (Dart 3.11.3 o superior)
- Android Studio (Emulador) o dispositivo físico configurado para depuración

## Instalación y Ejecución

1. Abre una nueva terminal y navega a la carpeta de la app:

```bash
cd app
```

2. Descarga las dependencias de Flutter:

```bash
flutter pub get
```

3. Ejecuta la aplicación (con el servidor ya corriendo):

```bash
flutter run
```

## Usuarios de prueba

El inicio de sesión es local, de demostración:

| Usuario          | Contraseña |
|------------------|------------|
| `usuario.prueba` | `1234`     |
| `admin`          | `1234`     |

## Uso

1. Inicia sesión y toca **Iniciar análisis**.
2. Elige el ejercicio y toca **Sube tu video** para seleccionar un video desde el teléfono.
3. Toca **Analizar video**. En unos segundos aparece el puntaje y el detalle por zona del cuerpo.
4. Cada análisis queda guardado en el historial de la pantalla de inicio.

Para un buen resultado: grabar de frente o de lado, con buena luz y con el cuerpo completo visible (de la cabeza a los pies).

---

# ⚠️ Importante — Conexión App → Servidor

- Si pruebas en un **Emulador de Android**, no hay que configurar nada: la app usa por defecto `http://10.0.2.2:8000`, que es la dirección con la que el emulador llega al servidor que corre en tu PC.

- Si pruebas en un **Teléfono Físico**, asegúrate de que el teléfono y el PC estén en la misma red Wi-Fi y ejecuta la app indicando la IP local de tu computadora:

```bash
flutter run --dart-define=API_URL=http://192.168.1.X:8000
```

Si el teléfono no logra conectarse, revisa que el firewall del PC permita conexiones entrantes al puerto 8000.

## Generar un APK instalable

```bash
flutter build apk --release --dart-define=API_URL=http://192.168.1.X:8000
```

El APK queda en `app/build/app/outputs/flutter-apk/app-release.apk`. Si el servidor está desplegado en la nube, usa su URL en `API_URL` (por ejemplo `https://mi-servidor.com`).

---

# 3. Despliegue del Servidor con Docker (opcional)

El servidor incluye el `Dockerfile` con el que se desplegó en Railway. Para construirlo y correrlo localmente:

```bash
cd servidor
docker build -t sportvision-servidor .
docker run -p 8000:8000 sportvision-servidor
```

En plataformas como Railway, el contenedor usa automáticamente el puerto que entrega la variable de entorno `PORT`.

---

# Estado del Proyecto

- Prototipo educativo: no es una herramienta médica ni clínica.
- El botón **Grabarse en tiempo real** todavía no está implementado (pantalla de maqueta); el análisis se hace sobre videos.
- El inicio de sesión es local y de demostración (sin backend de usuarios).
- El historial de sesiones se guarda localmente en el teléfono.

# Créditos

- Análisis de postura original (script de escritorio con webcam): Esteban Salgado — [ProyectoMovimiento-](https://github.com/EstebanSalgad0/ProyectoMovimiento-)
- Aplicación móvil, servidor de análisis e integración: Martin Ulloa
