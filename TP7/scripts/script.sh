#!/bin/bash


WIREGUARD_DIR="/etc/wireguard"
VPN_SUBNET="10.7.2.0/24"
SERVER_IP="10.7.1.100"
SERVER_PORT="51820"
DNS_SERVER="1.1.1.1"
PEERS=(
    "martine.tp7.secu 10.7.2.11"
    "bastion.tp7.secu 10.7.2.12"
    "web.tp7.secu 10.7.2.13"
    "pc.tp7.secu 10.7.2.100"
)

if [ "$(id -u)" -ne 0 ]; then
    echo "Ce script doit être exécuté en tant que root."
    exit 1
fi

mkdir -p $WIREGUARD_DIR
chmod 700 $WIREGUARD_DIR

echo "Génération des clés pour le serveur VPN..."
SERVER_PRIVATE_KEY=$(wg genkey)
SERVER_PUBLIC_KEY=$(echo "$SERVER_PRIVATE_KEY" | wg pubkey)

SERVER_CONF="$WIREGUARD_DIR/wg0.conf"
cat <<EOF > "$SERVER_CONF"
[Interface]
Address = $SERVER_IP/24
PrivateKey = $SERVER_PRIVATE_KEY
ListenPort = $SERVER_PORT
DNS = $DNS_SERVER

EOF

for peer in "${PEERS[@]}"; do
    PEER_NAME=$(echo "$peer" | awk '{print $1}')
    PEER_IP=$(echo "$peer" | awk '{print $2}')

    echo "Génération des clés pour $PEER_NAME..."
    PEER_PRIVATE_KEY=$(wg genkey)
    PEER_PUBLIC_KEY=$(echo "$PEER_PRIVATE_KEY" | wg pubkey)

    PEER_CONF="$WIREGUARD_DIR/${PEER_NAME}.conf"
    cat <<EOF > "$PEER_CONF"
[Interface]
Address = $PEER_IP/24
PrivateKey = $PEER_PRIVATE_KEY
DNS = $DNS_SERVER

[Peer]
PublicKey = $SERVER_PUBLIC_KEY
Endpoint = $SERVER_IP:$SERVER_PORT
AllowedIPs = $VPN_SUBNET
PersistentKeepalive = 25
EOF

    chmod 600 "$PEER_CONF"

    cat <<EOF >> "$SERVER_CONF"
[Peer]
PublicKey = $PEER_PUBLIC_KEY
AllowedIPs = $PEER_IP/32
EOF

    echo "Configuration pour $PEER_NAME générée : $PEER_CONF"
done

chmod 600 "$SERVER_CONF"

echo "Configuration du serveur générée : $SERVER_CONF"

echo "Redémarrage du service WireGuard..."
systemctl enable wg-quick@wg0
systemctl start wg-quick@wg0

echo "Configuration terminée !"
echo "Serveur et pairs configurés avec succès."
