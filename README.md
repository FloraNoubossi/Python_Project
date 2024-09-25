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

