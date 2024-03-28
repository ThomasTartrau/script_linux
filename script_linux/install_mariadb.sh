#!/bin/bash

# Vérifier si l'utilisateur est root
if [ "$(id -u)" != "0" ]; then
    echo "Ce script doit être exécuté en tant que root." 1>&2
    exit 1
fi

# Vérifier si un mot de passe a été fourni en argument
if [ -z "$1" ]; then
    echo "Veuillez fournir un mot de passe en argument." 1>&2
    exit 1
fi

# Mise à jour des paquets et installation de MariaDB Server
echo "Mise à jour des paquets et installation de MariaDB Server..."
sudo apt update > /dev/null 2>&1 && sudo apt install -y mariadb-server > /dev/null 2>&1

# Vérifier si l'installation a réussi
if [ $? -eq 0 ]; then
    echo "MariaDB Server a été installé avec succès."
else
    echo "Une erreur s'est produite lors de l'installation de MariaDB Server."
fi

# Exécuter mysql_secure_installation pour sécuriser l'installation de MariaDB
echo "Exécution de mysql_secure_installation..."

mysql_secure_installation <<EOF

y
$1
$1
y
y
y
y
EOF

echo "Configuration de MariaDB terminée."

# Modifier le fichier de configuration 50-server.cnf pour changer bind-address à 0.0.0.0
echo "Modification de /etc/mysql/mariadb.conf.d/50-server.cnf..."
sed -i 's/^bind-address.*/bind-address = 0.0.0.0/' /etc/mysql/mariadb.conf.d/50-server.cnf

# Redémarrer MariaDB pour appliquer les modifications de configuration
echo "Redémarrage de MariaDB pour appliquer les modifications de configuration..."
systemctl restart mariadb

echo "Configuration de MariaDB terminée."

# Fin du programme
exit 0
