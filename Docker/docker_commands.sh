#Guide CLI docker


# Construction d'une image Docker
docker build -t myimage .

# Construction d'une image à partir d'un Dockerfile situé dans un autre chemin
docker build -t myimage:latest -f /chemin/vers/ton/Dockerfile .

# Construction d'une image sans cache
docker build --no-cache -t myimage .

# Exécution d'un conteneur à partir d'une image
docker run --name mycontainer myimage

# Exécution en mode détaché (en arrière-plan)
docker run -d --name mycontainer myimage

# Exécution avec mapping des ports (exemple: port 80)
docker run -d --name mycontainer -p 80:80 myimage

# Montage de volume
docker run -d --name mycontainer -v /path/on/host:/path/in/container myimage

# Exécution en mode interactif
docker run -it myimage /bin/bash

# Lister les conteneurs en cours d'exécution
docker ps

# Lister tous les conteneurs (même ceux arrêtés)
docker ps -a

# Arrêter un conteneur
docker stop mycontainer

# Supprimer un conteneur arrêté
docker rm mycontainer

# Lister les images Docker disponibles localement
docker images

# Supprimer une image Docker
docker rmi myimage

# Exécuter une commande à l'intérieur d'un conteneur en cours d'exécution
docker exec mycontainer ls /app

# Afficher les logs d'un conteneur
docker logs mycontainer

# Inspecter un conteneur pour obtenir des informations détaillées
docker inspect mycontainer

# Télécharger une image depuis Docker Hub
docker pull nginx:latest

# Pousser une image vers un registre Docker
docker push myregistry/myimage:latest


Construire une image Docker à partir d'un fichier Docker (Dockerfile) avec différentes options :

Utiliser l'option -t pour taguer une image avec un nom et une version.
Utiliser l'option -f pour spécifier un fichier Docker situé à un emplacement différent.
Utiliser l'option --no-cache pour ne pas utiliser le cache pendant la construction.
Exécuter un conteneur Docker à partir d'une image Docker avec diverses options :

Utiliser --name pour donner un nom au conteneur.
Utiliser -d pour exécuter le conteneur en arrière-plan (détaché).
Utiliser -p pour mapper des ports du conteneur vers la machine hôte.
Utiliser -e pour définir des variables d'environnement.
Utiliser -v pour monter des volumes depuis l'hôte vers le conteneur.
Utiliser -it pour exécuter le conteneur en mode interactif (avec un terminal).
Gérer les conteneurs :

Lister les conteneurs en cours d'exécution (docker ps) ou tous les conteneurs, y compris ceux qui sont arrêtés (docker ps -a).
Arrêter un conteneur avec docker stop.
Supprimer un conteneur avec docker rm.
Gérer les images Docker :

Lister toutes les images disponibles localement avec docker images.
Supprimer une image avec docker rmi.
Exécuter des commandes dans un conteneur en cours d'exécution avec docker exec.

Consulter les logs d'un conteneur avec docker logs.

Obtenir des informations détaillées sur un conteneur ou une image avec docker inspect.

Télécharger une image depuis un registre (ex. Docker Hub) avec docker pull.

Envoyer une image vers un registre avec docker push.
