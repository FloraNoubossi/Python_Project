
#!/bin/bash

# Étape 1: Créer un réseau Docker
docker network create mynetwork

# Étape 2: Créer et attacher des conteneurs au réseau

# Créer le premier conteneur container1 et l'attacher au réseau mynetwork
docker run --name container1 --network mynetwork -d alpine sleep 3000

# Créer le deuxième conteneur container2 et l'attacher au réseau mynetwork
docker run --name container2 --network mynetwork -d alpine sleep 3000

# Créer le troisième conteneur container3 sans l'attacher au réseau mynetwork
docker run --name container3 -d alpine sleep 3000

# Étape 3: Tester la communication

# Pinger container1 depuis container2
docker exec container2 ping -c 4 container1

# Pinger container1 depuis container3 (qui n'est pas sur le même réseau)
docker exec container3 ping -c 4 container1 || echo "container3 ne peut pas atteindre container1 car ils ne sont pas sur le même réseau"

# Étape 4: Ajouter container3 au réseau mynetwork
docker network connect mynetwork container3

# Étape 5: Tester la communication à nouveau
docker exec container3 ping -c 4 container1

# Fin du script
