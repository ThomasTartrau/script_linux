#!/bin/bash

# Fonction pour vérifier si une commande a réussi ou échoué
check_error() {
    if [ $? -ne 0 ]; then
        echo "\033[91mErreur lors de l'exécution de la commande. Arrêt du script.\033[0m"
        exit 1
    fi
}

# Fonction pour afficher les messages de succès
success_message() {
    echo "\033[92m$1\033[0m"
}

# Installation des paquets sans afficher les détails
sudo apt update > /dev/null 2>&1 && sudo apt install apache2 libapache2-mod-php php php8.2-mysql php8.2-gd php8.2-imagick git -y > /dev/null 2>&1
check_error

success_message "Installation des paquets terminée avec succès."

# Vérification d'erreurs éventuelles
echo "Vérification des erreurs..."
if [ ! -x "$(command -v apache2)" ]; then
    echo "\033[91mErreur: Apache2 n'est pas installé correctement.\033[0m"
    exit 1
fi

if [ ! -x "$(command -v php)" ]; then
    echo "\033[91mErreur: PHP n'est pas installé correctement.\033[0m"
    exit 1
fi

if [ ! -x "$(command -v git)" ]; then
    echo "\033[91mErreur: Git n'est pas installé correctement.\033[0m"
    exit 1
fi

success_message "Aucune erreur détectée."

# Fin du script
exit 0
