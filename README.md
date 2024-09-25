# Python_Project
# Building a Docker Image for Python App

Ce projet décrit le processus de création et de déploiement d'une application Python simple avec FastAPI à l'intérieur d'un conteneur Docker.

## Objectif du projet

- Créer une application **FastAPI** simple qui affiche un message "Hello World".
- Conteneuriser cette application avec Docker en utilisant un **Dockerfile** personnalisé.
- Exécuter l'application à l'intérieur d'un conteneur Docker et la rendre accessible via un navigateur web.

## Technologies utilisées

- **Python** (avec le framework **FastAPI**)
- **Docker** (pour conteneuriser l'application)
- **Uvicorn** (pour exécuter l'application FastAPI à l'intérieur de Docker)

## Prérequis

- Docker installé sur votre machine
- Python 3.x installé (si vous voulez exécuter l'application localement)
- Un fichier `requirements.txt` pour gérer les dépendances Python

---

## Étapes du projet

### 1. Création de l'application Python avec FastAPI

Créez un fichier Python nommé **main.py** qui contient l'application **FastAPI** suivante :

```python
from fastapi import FastAPI

app = FastAPI()

@app.get("/")
async def root():
    return {"message": "Hello World!"}



Docker Volumes

Docker Network

Docker-compose




### Description

Ce projet utilise **Docker Compose** pour configurer une application Python Flask, un serveur Redis, et **pgAdmin** pour la gestion des bases de données PostgreSQL. L'application Flask utilise Redis pour stocker un compteur d'accès à une page.

### Structure du projet

Le projet inclut les fichiers suivants :
- `app.py`: L'application Flask.
- `requirements.txt`: Les dépendances Python nécessaires.
- `Dockerfile`: Configuration pour créer l'image Docker de l'application.
- `docker-compose.yml`: Fichier de configuration Docker Compose pour orchestrer les services.

### Prérequis

- Docker et Docker Compose installés.

### Étapes

#### 1. Créer un réseau Docker

   ```bash
   docker network create mynetwork
   ```

#### 2. Créer les conteneurs et les attacher au réseau

   Créer et lancer des conteneurs Redis, Flask, et pgAdmin en utilisant Docker Compose.

   Fichier `docker-compose.yml` :
   ```yaml
   version: '3'
   services:
     web:
       build: .
       ports:
         - "5000:5000"
       volumes:
         - .:/app
       depends_on:
         - redis-container

     redis-container:
       image: redis
       ports:
         - "6379:6379"

     pgadmin:
       image: dpage/pgadmin4
       environment:
         PGADMIN_DEFAULT_EMAIL: pgadmin4@pgadmin.org
         PGADMIN_DEFAULT_PASSWORD: postgres
       ports:
         - "5051:80"
   ```

   Lancer les services avec :
   ```bash
   docker-compose up --build
   ```

#### 3. Accéder aux services

- **Application Flask** : Accède à l'application sur `http://localhost:5000`.
- **pgAdmin** : Accède à l'interface pgAdmin via `http://localhost:5051` avec :
  - E-mail : `pgadmin4@pgadmin.org`
  - Mot de passe : `postgres`

#### 4. Arrêter les services

   Pour arrêter les conteneurs :
   ```bash
   docker-compose down
   ```

#### 5. Vérifications

- Vérifier les conteneurs en cours d'exécution :
  ```bash
  docker-compose ps
  ```

- Accéder aux logs pour diagnostiquer des erreurs :
  ```bash
  docker-compose logs
  ```

### Conclusion

Cette configuration permet de gérer une application Flask avec Redis et pgAdmin via Docker Compose. Il simplifie le déploiement et l'orchestration de plusieurs services pour un environnement de développement complet.


# Docker avec HTTPS

Ce projet montre comment configurer une application web Python Flask avec Redis, PgAdmin et Nginx à l'aide de Docker Compose, et comment sécuriser l'application avec HTTPS en utilisant un certificat SSL auto-signé.

## Prérequis

Assurez-vous d'avoir les éléments suivants installés :

- Docker
- Docker Compose

## Structure du projet

```
.
├── app.py                  # Fichier de l'application Flask
├── certs/                  # Dossier contenant le certificat SSL et la clé privée
├── docker-compose.yml       # Fichier de configuration Docker Compose
├── Dockerfile               # Dockerfile pour construire l'application Flask
├── nginx.conf               # Fichier de configuration Nginx
├── requirements.txt         # Dépendances Python pour l'application Flask
```

## Générer un certificat SSL

1. À la racine du projet, créez un dossier appelé `certs` :

   ```bash
   mkdir certs
   ```

2. Générez un certificat SSL auto-signé et une clé privée dans le dossier `certs/` en utilisant OpenSSL :

   ```bash
   openssl req -x509 -newkey rsa:4096 -keyout certs/key.pem -out certs/cert.pem -days 365 -nodes
   ```

   Pendant ce processus, vous devrez entrer des informations. Le **Nom Commun** (Common Name) est important et doit être défini sur **localhost** si vous utilisez ce certificat localement.

3. Attribuez les permissions appropriées à la clé privée :

   ```bash
   chmod +x certs/key.pem
   ```

## Configuration Docker

### `nginx.conf`

Voici le fichier de configuration Nginx qui permet de rediriger le trafic via HTTPS vers l'application Flask qui fonctionne sur le port 5000.

```nginx
events {}

http {
  upstream app {
    server web:5000;  # Utilise le service 'web' défini dans docker-compose.yml
  }

  server {
    listen 80;
    server_name localhost;
    return 301 https://$host$request_uri;  # Redirige le trafic HTTP vers HTTPS
  }

  server {
    listen 443 ssl;
    http2 on;
    server_name localhost;

    ssl_certificate /etc/ssl/certs/cert.pem;
    ssl_certificate_key /etc/ssl/certs/key.pem;

    location / {
      proxy_pass http://web:5000;  # Proxy vers le service Flask tournant sur le port 5000
      proxy_set_header Host $host;
      proxy_set_header X-Real-IP $remote_addr;
      proxy_set_header X-Forwarded-Proto https;
      proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
    }
  }
}
```

### `docker-compose.yml`

Voici le fichier de configuration Docker Compose qui définit les services utilisés dans ce projet : application Flask, Redis, PgAdmin et Nginx.

```yaml
version: '3'

services:
  web:
    build: .
    ports:
      - "5000:5000"
    volumes:
      - .:/app
    depends_on:
      - redis-container
    networks:
      - mynetwork

  redis-container:
    image: redis
    ports:
      - "6379:6379"
    networks:
      - mynetwork

  pgadmin:
    image: dpage/pgadmin4
    environment:
      PGADMIN_DEFAULT_EMAIL: pgadmin4@pgadmin.org
      PGADMIN_DEFAULT_PASSWORD: postgres
    ports:
      - "5051:80"
    networks:
      - db

  app:
    build: .
    ports:
      - "8000:8000"
    networks:
      - db
      - mynetwork

  nginx:
    image: nginx:latest
    ports:
      - "80:80"
      - "443:443"
    volumes:
      - ./nginx.conf:/etc/nginx/nginx.conf
      - ./certs:/etc/ssl/certs
    networks:
      - mynetwork
    depends_on:
      - app
    restart: always

networks:
  db:
    driver: bridge
  mynetwork:
    driver: bridge
```

### `Dockerfile`

Voici le Dockerfile utilisé pour construire l'application Flask.

```dockerfile
FROM python:3.9

WORKDIR /app

COPY . .

RUN pip install -r requirements.txt

CMD ["python", "app.py"]
```

### `app.py`

L'application web Flask incrémente un compteur stocké dans Redis à chaque fois que la page d'accueil est consultée.

```python
from flask import Flask
from redis import Redis

app = Flask(__name__)
redis = Redis(host='redis-container', port=6379)

@app.route('/')
def hello():
    redis.incr('hits')
    hits = redis.get('hits').decode('utf-8')
    return f'This page has been viewed {hits} time(s).'

if __name__ == "__main__":
    app.run(host="0.0.0.0", debug=True)
```

## Utilisation

1. Construisez et lancez les services avec Docker Compose :

   ```bash
   docker-compose up --build
   ```

2. Une fois les services lancés, vous pouvez accéder à l'application via HTTPS :

   - Application Flask : `https://localhost`
   - PgAdmin : `http://localhost:5051`

   **Note** : Vous devrez probablement contourner l'avertissement SSL du navigateur puisque vous utilisez un certificat auto-signé.

3. Vous pouvez également consulter les logs pour vérifier que les services fonctionnent correctement :

   ```bash
   docker-compose logs
   ```

4. Pour arrêter les services, utilisez :

   ```bash
   docker-compose down
   ```
   ## Connexion à pgAdmin : http://localhost:5051/login?next=/
   et à https://localhost/ 

![image](https://github.com/user-attachments/assets/b8a38b6a-7063-4ca6-a114-bca02fae5ce8)
![image](https://github.com/user-attachments/assets/8f21496a-11e1-49fd-815b-76aff1406ca5)



