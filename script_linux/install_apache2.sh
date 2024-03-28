#!/bin/bash

# Fonction pour vérifier si une commande a réussi ou échoué
check_error() {
    if [ $? -ne 0 ]; then
        echo "Erreur lors de l'exécution de la commande. Arrêt du script."
        exit 1
    fi
}

# Installation des paquets sans afficher les détails
sudo apt update > /dev/null 2>&1 && sudo apt install apache2 libapache2-mod-php php php8.2-mysql php8.2-gd php8.2-imagick git -y > /dev/null 2>&1
check_error

echo "Installation des paquets terminée avec succès."

# Vérification d'erreurs éventuelles
echo "Vérification des erreurs..."
if [ ! -x "$(command -v apache2)" ]; then
    echo "Erreur: Apache2 n'est pas installé correctement."
    exit 1
fi

if [ ! -x "$(command -v php)" ]; then
    echo "Erreur: PHP n'est pas installé correctement."
    exit 1
fi

if [ ! -x "$(command -v git)" ]; then
    echo "Erreur: Git n'est pas installé correctement."
    exit 1
fi

echo "Aucune erreur détectée."

# Fin du script
exit 0
