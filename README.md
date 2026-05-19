# Proyecto Medicina App (IA + Flutter)

Este repositorio contiene una aplicación móvil en Flutter y un servidor backend en Python que ejecuta un modelo de Inteligencia Artificial (MediaPipe) para evaluar movimientos corporales.

---

# Estructura del Proyecto

- `/app`: Código fuente de la aplicación móvil (Flutter).
- `/servidor`: Código fuente del modelo de IA y la API (Python/FastAPI).

---

# 1. Configuración y Ejecución del Servidor (IA)

## Requisitos

- Python 3.10+ (recomendado 3.12)
- Webcam funcional (Solo para el modelo IA, la aplicación móvil tiene su integración propia en cámara)

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

---

# 2. Configuración y Ejecución de la App (Flutter)

## Requisitos

- Flutter SDK instalado
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

3. Ejecuta la aplicación:

```bash
flutter run
```

---

# ⚠️ Importante — Conexión App → Servidor

- Si pruebas en un **Emulador de Android**, la IP para conectarse al servidor local (tu PC) no es `localhost`, debes usar:

```text
10.0.2.2:8000
```

- Si pruebas en un **Teléfono Físico**, asegúrate de que el teléfono y el PC estén en la misma red Wi-Fi y usa la IP local de tu computadora:

```text
192.168.1.X:8000
```