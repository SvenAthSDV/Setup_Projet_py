#!/bin/bash

# Mettre à jour et mettre à niveau Ubuntu
echo "Mise à jour des paquets..."
sudo apt-get update && sudo apt-get upgrade -y

# Installer Python et pip
echo "Installation de Python et pip..."
sudo apt-get install -y python3 python3-pip

# Demander le nom de l'environnement virtuel
read -p "Entrez le nom de votre environnement virtuel: " venv_name

# Installer virtualenv si ce n'est pas déjà fait
if ! pip3 show virtualenv > /dev/null; then
    echo "Installation de virtualenv..."
    sudo pip3 install virtualenv
fi

# Créer l'environnement virtuel
echo "Création de l'environnement virtuel '${venv_name}'..."
virtualenv "$venv_name"

# Changer le répertoire de travail pour celui de l'environnement virtuel
cd "$venv_name"

# Activer l'environnement virtuel
echo "Activation de l'environnement virtuel..."
source "bin/activate"

# Demander à l'utilisateur les modules à installer
echo "Entrez les noms des modules à installer, séparés par des espaces :"
read -a modules

# Sauvegarder les modules dans requirements.txt
echo "Sauvegarde des modules dans requirements.txt..."
printf "%s\n" "${modules[@]}" > requirements.txt

# Installer les modules à partir de requirements.txt
echo "Installation des modules..."
pip install -r requirements.txt

echo "Configuration terminée. L'environnement virtuel '${venv_name}' est prêt à être utilisé avec les modules installés."
