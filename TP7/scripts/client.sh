#!/bin/bash

# Vérification que le script est exécuté en tant que root
if [ "$(id -u)" -ne 0 ]; then
    echo "Ce script doit être exécuté en tant que root."
    exit 1
fi

# Vérification que WireGuard est installé
if ! command -v wg &> /dev/null; then
    echo "WireGuard n'est pas installé. Veuillez installer WireGuard avant de lancer ce script."
    exit 1
fi

# Génération des clés privées et publiques pour le client
echo "Génération des clés privées et publiques..."
CLIENT_PRIVATE_KEY=$(wg genkey)
CLIENT_PUBLIC_KEY=$(echo "$CLIENT_PRIVATE_KEY" | wg pubkey)

# Création du fichier de configuration client
CLIENT_CONF_PATH="/etc/wireguard/wg0-client.conf"

echo "Création du fichier de configuration WireGuard pour le client..."

cat > "$CLIENT_CONF_PATH" <<EOL
[Interface]
PrivateKey = $CLIENT_PRIVATE_KEY
Address = 10.7.2.2/24
DNS = 8.8.8.8

[Peer]
PublicKey = <PublicKey_serveur>
Endpoint = <IP_du_serveur_VPN>:51820
AllowedIPs = 10.7.2.0/24
PersistentKeepalive = 25
EOL

echo "Fichier de configuration généré à : $CLIENT_CONF_PATH"

# Affichage de la section [Peer] pour l'ajouter au fichier de configuration du serveur
echo ""
echo "Voici la section à ajouter à la configuration du serveur :"
echo "[Peer]"
echo "PublicKey = $CLIENT_PUBLIC_KEY"
echo "AllowedIPs = 10.7.2.2/32"
echo ""

# Ajout d'un alias 'vpn' pour simplifier la connexion
echo "Création d'un alias pour se connecter au VPN..."
echo "alias vpn='wg-quick up wg0-client'" >> ~/.bashrc

# Appliquer l'alias pour la session actuelle
source ~/.bashrc

echo "L'alias 'vpn' a été ajouté à votre fichier ~/.bashrc."
echo "Vous pouvez maintenant vous connecter au VPN en exécutant 'vpn' dans le terminal."

# Rappel à l'utilisateur
echo "N'oubliez pas de modifier '<PublicKey_serveur>' et '<IP_du_serveur_VPN>' dans la configuration client avant de l'utiliser."
echo "Une fois configuré, vous pouvez démarrer la connexion VPN avec la commande :"
echo "vpn"