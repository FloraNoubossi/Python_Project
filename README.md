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










## README

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


