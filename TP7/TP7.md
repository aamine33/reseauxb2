TP7 SECU : Accès réseau sécurisé

Sommaire


TP7 SECU : Accès réseau sécurisé

Sommaire :
```
1.VPN
II. SSH
    1.Setup
    2.Bastion
    3.Connexion par clé
    4.Conf serveur SSH
III. HTTP
    1.Initial setup
    2.Génération de certificat et HTTPS
        A.Préparation de la CA
        B.Générayion du certificat pour le serveur web
        C.Bonnes pratiques RedhHat
        D.Config serveur Web
        E.Bonus renforcement TLS
```

I. VPN

🌞 Monter un serveur VPN Wireguard sur vpn.tp7.secu
```
sudo dnf install epel-release -y
sudo dnf install wireguard-tools -y
[vpn.tp7.secu@localhost ~]$ sudo wg --version
wireguard-tools v1.0.20210914 - https://git.zx2c4.com/wireguard-tools/
[vpn.tp7.secu@localhost ~]$ sudo setenforce 0
[vpn.tp7.secu@localhost ~]$ sudo cat /etc/wireguard/privatekey | wg pubkey | sudo tee /etc/wireguard/publickey > /dev/null
[vpn.tp7.secu@localhost ~]$ sudo cat /etc/wireguard/privatekey
ePdNzOC7xcgdKGhMTTt4PBh/dSp9X6gCSAAyqQeW8Eo=
[vpn.tp7.secu@localhost ~]$ sudo cat /etc/wireguard/publickey
lRUvijoVsysnBLmqCsUMkN2+Qt4hdPMFcpEjrUbF11o=
[vpn.tp7.secu@localhost ~]$ sudo nano /etc/wireguard/wg0.conf
[Interface]
Address = 10.7.2.1/24
SaveConfig = false
PostUp = firewall-cmd --add-interface=wg0 --permanent; firewall-cmd --add-masquerade --permanent; firew>
PostDown = firewall-cmd --remove-interface=wg0 --permanent; firewall-cmd --remove-masquerade --permanen>
ListenPort = 51820
PrivateKey = ePdNzOC7xcgdKGhMTTt4PBh/dSp9X6gCSAAyqQeW8Eo=

[Peer]
PublicKey = /DrYAT61kaRcJoyr6q7nxm5Zd7oJleXcqC54GlnZQBw=
AllowedIPs = 10.7.2.11/32

[vpn.tp7.secu@localhost ~]$ sudo wg show
interface: wg0
  public key: lRUvijoVsysnBLmqCsUMkN2+Qt4hdPMFcpEjrUbF11o=
  private key: (hidden)
  listening port: 51820

peer: /DrYAT61kaRcJoyr6q7nxm5Zd7oJleXcqC54GlnZQBw=
  endpoint: 10.7.1.11:34681
  allowed ips: 10.7.2.11/32
  latest handshake: 43 seconds ago
  transfer: 3.00 KiB received, 2.39 KiB sent
```
🌞 Client Wireguard sur martine.tp7.secu
```
sudo dnf install epel-release -y
sudo dnf install wireguard-tools -y
[martine.tp7.secu@localhost ~]$ sudo setenforce 0
[martine.tp7.secu@localhost ~]$ sudo nano /etc/sysconfig/selinux 
[martine.tp7.secu@localhost ~]$ sudo wg genkey | sudo tee /etc/wireguard/privatekey > /dev/null
[martine.tp7.secu@localhost ~]$ sudo cat /etc/wireguard/privatekey | wg pubkey | sudo tee /etc/wireguard/publickey > /dev/null
[martine.tp7.secu@localhost ~]$ sudo cat /etc/wireguard/privatekey
UGuOEA5IN5uGeGHHTC1vui27LBQyNCA61qydCrbx/Hc=
[martine.tp7.secu@localhost ~]$ sudo cat /etc/wireguard/publickey
/DrYAT61kaRcJoyr6q7nxm5Zd7oJleXcqC54GlnZQBw=
[martine.tp7.secu@localhost ~]$ sudo nano /etc/wireguard/wg0.conf
[root@localhost wireguard]# cat wg0.conf 
[Interface]
Address = 10.7.2.11/24
PrivateKey = UGuOEA5IN5uGeGHHTC1vui27LBQyNCA61qydCrbx/Hc=

[Peer]
PublicKey = lRUvijoVsysnBLmqCsUMkN2+Qt4hdPMFcpEjrUbF11o=
AllowedIPs = 0.0.0.0/0, ::/0
Endpoint = 10.7.1.100:51820
PersistentKeepalive = 25
[martine.tp7.secu@localhost ~]$ sudo systemctl enable wg-quick@wg0
Created symlink /etc/systemd/system/multi-user.target.wants/wg-quick@wg0.service → /usr/lib/systemd/system/wg-quick@.service.
[martine.tp7.secu@localhost ~]$ sudo systemctl start wg-quick@wg0
[martine.tp7.secu@localhost ~]$ sudo systemctl status wg-quick@wg0
● wg-quick@wg0.service - WireGuard via wg-quick(8) for wg0
     Loaded: loaded (/usr/lib/systemd/system/wg-quick@.service; enabled; preset: disabled)
     Active: active (exited) since Fri 2024-11-22 14:28:24 CET; 4s ago
       Docs: man:wg-quick(8)
             man:wg(8)
             https://www.wireguard.com/
             https://www.wireguard.com/quickstart/
             https://git.zx2c4.com/wireguard-tools/about/src/man/wg-quick.8
             https://git.zx2c4.com/wireguard-tools/about/src/man/wg.8
    Process: 9172 ExecStart=/usr/bin/wg-quick up wg0 (code=exited, status=0/SUCCESS)
   Main PID: 9172 (code=exited, status=0/SUCCESS)
        CPU: 52ms
[root@localhost wireguard]# wg show
interface: wg0
  public key: /DrYAT61kaRcJoyr6q7nxm5Zd7oJleXcqC54GlnZQBw=
  private key: (hidden)
  listening port: 34681
  fwmark: 0xca6c

peer: lRUvijoVsysnBLmqCsUMkN2+Qt4hdPMFcpEjrUbF11o=
  endpoint: 10.7.1.100:51820
  allowed ips: 0.0.0.0/0, ::/0
  latest handshake: 2 seconds ago
  transfer: 92 B received, 180 B sent
  persistent keepalive: every 25 seconds
[root@localhost wireguard]# ping 10.7.2.1
PING 10.7.2.1 (10.7.2.1) 56(84) bytes of data.
64 bytes from 10.7.2.1: icmp_seq=1 ttl=64 time=2.21 ms
64 bytes from 10.7.2.1: icmp_seq=2 ttl=64 time=1.94 ms
64 bytes from 10.7.2.1: icmp_seq=3 ttl=64 time=0.803 ms
64 bytes from 10.7.2.1: icmp_seq=4 ttl=64 time=2.21 ms
64 bytes from 10.7.2.1: icmp_seq=5 ttl=64 time=1.93 ms
64 bytes from 10.7.2.1: icmp_seq=6 ttl=64 time=2.21 ms
```
🌞 Client Wireguard sur votre PC
```
sudo apt install wireguard
batman@BATPC:~$ cat ~/privatekey
QPhPVh379xPUDVfSikM8GTHMpP/blEzm921vVbIA70s=
batman@BATPC:~$ cat ~/publickey
g02Jx+jrZaHYIb1HS2vvTujAA0BKjH4OIddkeZ68G3Y=
batman@BATPC:~$ sudo cat /etc/wireguard/wg0.conf
[Interface]
Address = 10.7.2.100/24
PrivateKey = QPhPVh379xPUDVfSikM8GTHMpP/blEzm921vVbIA70s=

[Peer]
PublicKey = lRUvijoVsysnBLmqCsUMkN2+Qt4hdPMFcpEjrUbF11o=
AllowedIPs = 10.7.2.0/24, 0.0.0.0/0  
Endpoint = 10.7.1.100:51820
PersistentKeepalive = 25

batman@BATPC:~$ sudo systemctl enable wg-quick@wg0
Created symlink /etc/systemd/system/multi-user.target.wants/wg-quick@wg0.service → /lib/systemd/system/wg-quick@.service.
batman@BATPC:~$ sudo systemctl start wg-quick@wg0
batman@BATPC:~$ sudo systemctl status wg-quick@wg0
● wg-quick@wg0.service - WireGuard via wg-quick(8) for wg0
     Loaded: loaded (/lib/systemd/system/wg-quick@.service; enabled; preset: enabled)
     Active: active (exited) since Fri 2024-11-22 10:50:15 CET; 3s ago
       Docs: man:wg-quick(8)
             man:wg(8)
             https://www.wireguard.com/
             https://www.wireguard.com/quickstart/
             https://git.zx2c4.com/wireguard-tools/about/src/man/wg-quick.8
             https://git.zx2c4.com/wireguard-tools/about/src/man/wg.8
    Process: 26315 ExecStart=/usr/bin/wg-quick up wg0 (code=exited, status=0/SUCCESS)
   Main PID: 26315 (code=exited, status=0/SUCCESS)
        CPU: 44ms
batman@BATPC:~$ sudo wg show
interface: wg0
  public key: g02Jx+jrZaHYIb1HS2vvTujAA0BKjH4OIddkeZ68G3Y=
  private key: (hidden)
  listening port: 42192
  fwmark: 0xca6c

peer: ePdNzOC7xcgdKGhMTTt4PBh/dSp9X6gCSAAyqQeW8Eo=
  endpoint: 10.7.1.100:51820
  allowed ips: 10.7.2.0/24, 0.0.0.0/0
  transfer: 0 B received, 444 B sent
  persistent keepalive: every 25 seconds

batman@BATPC:~$ ping 10.7.2.11
PING 10.7.2.11 (10.7.2.11) 56(84) bytes of data.
64 bytes from 10.7.2.11: icmp_seq=1 ttl=63 time=1.35 ms
64 bytes from 10.7.2.11: icmp_seq=2 ttl=63 time=3.89 ms
64 bytes from 10.7.2.11: icmp_seq=3 ttl=63 time=1.50 ms
^C
--- 10.7.2.11 ping statistics ---
3 packets transmitted, 3 received, 0% packet loss, time 2003ms
rtt min/avg/max/mdev = 1.349/2.246/3.893/1.165 ms

( le fichier /etc/wireguard/wg0.conf mis à jour sur vpn.tp7.secu :
  GNU nano 5.6.1                           /etc/wireguard/wg0.conf                                      
[Interface]
Address = 10.7.2.1/24
SaveConfig = false
PostUp = firewall-cmd --add-interface=wg0 --permanent; firewall-cmd --add-masquerade --permanent; firew>
PostDown = firewall-cmd --remove-interface=wg0 --permanent; firewall-cmd --remove-masquerade --permanen>
ListenPort = 51820
PrivateKey = ePdNzOC7xcgdKGhMTTt4PBh/dSp9X6gCSAAyqQeW8Eo=

[Peer]
PublicKey = /DrYAT61kaRcJoyr6q7nxm5Zd7oJleXcqC54GlnZQBw=
AllowedIPs = 10.7.2.11/32

[Peer]
PublicKey = g02Jx+jrZaHYIb1HS2vvTujAA0BKjH4OIddkeZ68G3Y=
AllowedIPs = 0.0.0.0/0, ::/0
Endpoint = 10.33.68.88:51820
PersistentKeepalive =25
)
```
🌞 Ecrire un script client.sh
```
batman@BATPC:~$ sudo nano client.sh
[sudo] Mot de passe de batman : 
batman@BATPC:~$ sudo chmod +X client.sh 
batman@BATPC:~$ sudo ./client.sh
batman@BATPC:~$ sudo ./client.sh
Génération des clés privées et publiques...
Création du fichier de configuration WireGuard pour le client...
Fichier de configuration généré à : /etc/wireguard/wg0-client.conf

Voici la section à ajouter à la configuration du serveur :
[Peer]
PublicKey = PZGEJNsPhFJVYTThPM5fUpFlx/zJsO5yVRhmB0vWWkQ=
AllowedIPs = 10.7.2.2/32

Création d'un alias pour se connecter au VPN...
L'alias 'vpn' a été ajouté à votre fichier ~/.bashrc.
Vous pouvez maintenant vous connecter au VPN en exécutant 'vpn' dans le terminal.
N'oubliez pas de modifier '<PublicKey_serveur>' et '<IP_du_serveur_VPN>' dans la configuration client avant de l'utiliser.
Une fois configuré, vous pouvez démarrer la connexion VPN avec la commande :
vpn
batman@BATPC:~$ vpn
[#] ip link add wg0-client type wireguard
[#] wg setconf wg0-client /dev/fd/63
Key is not the correct length or format: `<PublicKey_serveur>'
Configuration parsing error
[#] ip link delete dev wg0-client
```

II. SSH

1. Setup

🌞 Générez des confs Wireguard pour tout le monde
```
2 facons de faire : soit refaire la meme confifuration juste avant pour les machines bastion et web en modifiant de ce fait le fichier de configuration dans le vpn.tp7.secu en rajoutant deux sections [Peer] avec les ips et les clés publiques. Ou alors avec un script , cf "script.sh" dans le dossier script du dossier tp7.
```

2. Bastion

🌞 Empêcher la connexion SSH directe sur web.tp7.secu
```
[web.tp7.secu@localhost ~]$ sudo firewall-cmd --permanent --add-rich-rule='rule family="ipv4" source address="10.7.2.12" port protocol="tcp" port="22" accept'
[sudo] password for web.tp7.secu: 
success
[web.tp7.secu@localhost ~]$ sudo firewall-cmd --permanent --add-rich-rule='rule family="ipv4" port protocol="tcp" port="22" reject'
success
[web.tp7.secu@localhost ~]$ sudo firewall-cmd --reload
success
```

🌞 Connectez-vous avec un jump SSH
```
[bastion.tp7.secu@localhost ~]$ ssh -J 10.7.2.12 10.7.2.13
The authenticity of host '10.7.2.12 (10.7.2.12)' can't be established.
ED25519 key fingerprint is SHA256:48U2ndHeTE59ccF5HC0eEG4wALNG4yomuvAer6eFfgU.
This key is not known by any other names
Are you sure you want to continue connecting (yes/no/[fingerprint])? yes
Warning: Permanently added '10.7.2.12' (ED25519) to the list of known hosts.
bastion.tp7.secu@10.7.2.12's password: 
```

3. Connexion par clé

🌞 Générez une nouvelle paire de clés pour ce TP
```
ssh-keygen -t ed25519 -a 100
Pour générer des clés SSH sécurisées sans utiliser RSA, le meilleur choix en 2023 est Ed25519. Voici pourquoi :
Ed25519

    Sécurité : C'est un algorithme basé sur les courbes elliptiques, offrant une sécurité équivalente à RSA-3072 mais avec une clé plus petite et plus rapide.
    Performances : Plus rapide que RSA pour générer des clés et vérifier des signatures.
    Avantages :
        Résistant aux attaques par canal latéral.
        Plus sécurisé et rapide que RSA.
        Clé plus courte mais avec la même sécurité qu'une clé RSA plus grande.

Pourquoi choisir Ed25519 ?

C'est aujourd'hui l'algorithme recommandé pour SSH, car il combine sécurité et performances optimisées.

Pour finir, il offre une meilleure sécurité et des performances optimisées par rapport à RSA et ECDSA, ce qui en fait le choix préféré en 2023 pour les connexions SSH.
```

4. Conf serveur SSH

🌞 Changez l'adresse IP d'écoute
```
sur chaque VM et le pc , taper la commande : sudo nano/vi /etc/ssh/sshd_config
- Pour vpn.tp7.secu = ListenAddress 10.7.2.100
- Pour martine.tp7.secu = ListenAddress 10.7.2.11
- Pour bastion.tp7.secu = ListenAddress 10.7.2.12
- Pour web.tp7.secu = ListenAddress 10.7.2.13
et taper cette commande après chaque modification du fichier d'une VM = sudo systemctl restart sshd
```

🌞 Améliorer le niveau de sécurité du serveur
```
- Désactiver l'accès par mot de passe : PasswordAuthentication no
- Restreindre l'accès SSH à un seul utilisateur : AllowUsers user
- Forcer les protocoles modernes : KexAlgorithms curve25519-sha256@libssh.org
```

III. HTTP

1. Initial setup

🌞 Monter un bête serveur HTTP sur web.tp7.secu
```
[web.tp7.secu@localhost ~]$ sudo dnf install nginx -y
[web.tp7.secu@localhost ~]$ sudo mkdir -p /var/www/site_nul
[sudo] password for web.tp7.secu: 
[web.tp7.secu@localhost ~]$ echo "toto" | sudo tee /var/www/site_nul/index.html
toto
[web.tp7.secu@localhost ~]$ sudo nano /etc/nginx/conf.d/default.conf
[web.tp7.secu@localhost ~]$ sudo cat /etc/nginx/conf.d/default.conf
server {
    server_name web.tp7.secu;

    listen 10.7.2.13:80;

    root /var/www/site_nul;
    index index.html;
}
[web.tp7.secu@localhost ~]$ sudo systemctl enable nginx
Created symlink /etc/systemd/system/multi-user.target.wants/nginx.service → /usr/lib/systemd/system/nginx.service.
[web.tp7.secu@localhost ~]$ sudo systemctl start nginx
[web.tp7.secu@localhost ~]$ sudo systemctl status nginx
● nginx.service - The nginx HTTP and reverse proxy server
     Loaded: loaded (/usr/lib/systemd/system/nginx.service; enabled; preset: disabled)
     Active: active (running) since Fri 2024-11-22 21:58:03 CET; 3s ago
    Process: 10002 ExecStartPre=/usr/bin/rm -f /run/nginx.pid (code=exited, status=0/SUCCESS)
    Process: 10003 ExecStartPre=/usr/sbin/nginx -t (code=exited, status=0/SUCCESS)
    Process: 10004 ExecStart=/usr/sbin/nginx (code=exited, status=0/SUCCESS)
   Main PID: 10005 (nginx)
      Tasks: 4 (limit: 28800)
     Memory: 3.9M
        CPU: 47ms
     CGroup: /system.slice/nginx.service
             ├─10005 "nginx: master process /usr/sbin/nginx"
             ├─10006 "nginx: worker process"
             ├─10007 "nginx: worker process"
             └─10008 "nginx: worker process"

Nov 22 21:58:03 localhost.localdomain systemd[1]: Starting The nginx HTTP and reverse proxy server...
Nov 22 21:58:03 localhost.localdomain nginx[10003]: nginx: the configuration file /etc/nginx/nginx.con>
Nov 22 21:58:03 localhost.localdomain nginx[10003]: nginx: configuration file /etc/nginx/nginx.conf te>
Nov 22 21:58:03 localhost.localdomain systemd[1]: Started The nginx HTTP and reverse proxy server.

[web.tp7.secu@localhost ~]$ sudo systemctl reload nginx
```

🌞 Site web joignable qu'au sein du réseau VPN
```
[web.tp7.secu@localhost ~]$ sudo iptables -A INPUT -p tcp --dport 80 -s 10.7.2.0/24 -j ACCEPT
[web.tp7.secu@localhost ~]$ sudo iptables -A INPUT -p tcp --dport 80 -j DROP
[web.tp7.secu@localhost ~]$ sudo systemctl enable iptables
Created symlink /etc/systemd/system/multi-user.target.wants/iptables.service → /usr/lib/systemd/system/iptables.service.
[web.tp7.secu@localhost ~]$ sudo systemctl start iptables
[web.tp7.secu@localhost ~]$ sudo systemctl status iptables
● iptables.service - IPv4 firewall with iptables
     Loaded: loaded (/usr/lib/systemd/system/iptables.service; enabled; preset: disabled)
     Active: active (exited) since Fri 2024-11-22 22:03:44 CET; 3s ago
    Process: 10177 ExecStart=/usr/libexec/iptables/iptables.init start (code=exited, status=0/SUCCESS)
   Main PID: 10177 (code=exited, status=0/SUCCESS)
        CPU: 18ms

Nov 22 22:03:43 localhost.localdomain systemd[1]: Starting IPv4 firewall with iptables...
Nov 22 22:03:44 localhost.localdomain iptables.init[10177]: iptables: Applying firewall rules: [  OK  ]
Nov 22 22:03:44 localhost.localdomain systemd[1]: Finished IPv4 firewall with iptables.
[web.tp7.secu@localhost ~]$ sudo service iptables save
iptables: Saving firewall rules to /etc/sysconfig/iptables: [  OK  ]
```

🌞 Accéder au site web
```
[web.tp7.secu@localhost ~]$ curl http://10.7.2.13
toto
```

2. Génération de certificat et HTTPS

A. Préparation de la CA

🌞 Générer une clé et un certificat de CA
```
[web.tp7.secu@localhost ~]$ openssl genrsa -des3 -out CA.key 4096
Enter PEM pass phrase:
Verifying - Enter PEM pass phrase:
[web.tp7.secu@localhost ~]$ openssl req -x509 -new -nodes -key CA.key -sha256 -days 1024 -out CA.pem
Enter pass phrase for CA.key:
[web.tp7.secu@localhost ~]$ openssl req -new -nodes -out web.tp7.secu.csr -newkey rsa:4096 -keyout web.tp7.secu.key
..+...............+...+.+......+..+.+.....+....+...........+.+......+.....+..........+.....+...+......+....+...........+......+....+........+.+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++*....+....+..+...+.+...............+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++*.......+................+.....+.+..............+.........+.......+...+.....+...+...+.+.....+.+...+.........+........+....+.........+.....+.......+.........+...+..+...+......................+......+..+..........+..+....+..+...........................+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
...+......+..+.+.....+................+.....+.+...+..+...+....+.....+.......+...+...+...+.........+............+.........+..+....+...+........+...+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++*...+............+.......+..............+.......+.........+......+...+.....+....+..+...+.......+...+........+...+.......+..+.............+..+......+......+......+.........+.+.....+....+...+...+........+....+......+..............+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++*...+.......+...+...+.........+........+...+....+............+......+...+.....+.......+..+.......+...+...............+.................+.+...+.................+............+...+....+...............+.........+.....+............+.......+......+...........+...+.+...............+............+..+.+...........................+..+.+......+...+...................................+...+....+...+......+.....+....+.....+..........+......+...........+...+...+...............+....+...+..+......+...+....+......+.........+..+...+.+......+...+........+.......+.....+...............+...+....+......+.........+...........+............+.+......+.....+......+...+.....................+....+.....+......+.............+..+.........+....+...+.....+............+.......+...+........+...+.+...+........+...+.+...+......+...........+.+..+..........+..+..........+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
-----
You are about to be asked to enter information that will be incorporated
into your certificate request.
What you are about to enter is what is called a Distinguished Name or a DN.
There are quite a few fields but you can leave some blank
For some fields there will be a default value,
If you enter '.', the field will be left blank.
-----
Country Name (2 letter code) [XX]:
State or Province Name (full name) []:
Locality Name (eg, city) [Default City]:
Organization Name (eg, company) [Default Company Ltd]:
Organizational Unit Name (eg, section) []:
Common Name (eg, your name or your server's hostname) []:
Email Address []:

Please enter the following 'extra' attributes
to be sent with your certificate request
A challenge password []:
An optional company name []:
```

B. Génération du certificat pour le serveur web

🌞 Générer une clé et une demande de signature de certificat pour notre serveur web
```
[web.tp7.secu@localhost ~]$ openssl req -new -nodes -out web.tp7.secu.csr -newkey rsa:4096 -keyout web.tp7.secu.key
.........+.....+...+...+....+...+..+.......+.....+.+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++*.+.................+...+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++*.............+...+....+............+...+..+....+..+...+..........+..............+......+.+.....+...+.......+...+..+......+.........................+...+..+.............+.........+...+........+....+..+...+............+.+........+.+.....+................+...+..+...............+.........+....+.....+.+......+..+.+...........+...+.............+.........+...+...+..+...+....+......+.....+...............+.........+....+.....+.+...+...+.....+....+.....+..................+...+...+.+.....+.............+...........+.......+.......................+.+...........+.........+.+...+.....+.......+........+.........+..........+..+......+......................+..+..........+...+........+.........+....+......+.....+...+.......+........+......+.......+...+..+.......+......+.........+........+..........+........+....+...........+.+.....+.+...+.........+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
....+.........+.+......+.........+......+.........+......+...+.....+......+.+...+..+.............+.....+............+.........+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++*..............+...+.+...+..+....+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++*.+......+.......+.....+...............+...+.........+................+......+...+...+..+......+.......+..+.+...............+..........................+.+.................+............+......+...+...................+...........+.+.....+...+.+..+.......+...+..+...............................+..+....+...........+...+.+..............+.+...+..........................+....+............+.....+.............+..+....+..+.......+...........+.+........+...+...+...............+.......+.....+....+......+.....+.........+....+..+..........+............+..+.........+.+......+........+.+.........+..............+.+......+.....+.........+.......+.....+...+.......+.................+......+.......+..+.+.........+...+...+.................+...+.........+................+..+.........+.+.........+.........+......+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
-----
You are about to be asked to enter information that will be incorporated
into your certificate request.
What you are about to enter is what is called a Distinguished Name or a DN.
There are quite a few fields but you can leave some blank
For some fields there will be a default value,
If you enter '.', the field will be left blank.
-----
Country Name (2 letter code) [XX]:
State or Province Name (full name) []:
Locality Name (eg, city) [Default City]:
Organization Name (eg, company) [Default Company Ltd]:
Organizational Unit Name (eg, section) []:
Common Name (eg, your name or your server's hostname) []:
Email Address []:

Please enter the following 'extra' attributes
to be sent with your certificate request
A challenge password []:
An optional company name []:
```

🌞 Faire signer notre certificat par la clé de la CA
```
[web.tp7.secu@localhost ~]$ sudo nano v3.ext
[sudo] password for web.tp7.secu: 
[web.tp7.secu@localhost ~]$ sudo cat v3.ext 
authorityKeyIdentifier=keyid,issuer
basicConstraints=CA:FALSE
keyUsage = digitalSignature, nonRepudiation, keyEncipherment, dataEncipherment
subjectAltName = @alt_names

[alt_names]
DNS.1 = web.tp7.secu
DNS.2 = www.tp7.secu
[web.tp7.secu@localhost ~]$ openssl x509 -req -in web.tp7.secu.csr -CA CA.pem -CAkey CA.key -CAcreateserial -out web.tp7.secu.crt -days 500 -sha256 -extfile v3.ext
Certificate request self-signature ok
subject=C = XX, L = Default City, O = Default Company Ltd
Enter pass phrase for CA.key:
```
C. Bonnes pratiques RedHat

🌞 Déplacer les clés et les certificats dans l'emplacement réservé
```
[web.tp7.secu@localhost ~]$ sudo mv web.tp7.secu.crt /etc/pki/tls/certs/
[web.tp7.secu@localhost ~]$ sudo mv web.tp7.secu.key /etc/pki/tls/private/
[web.tp7.secu@localhost ~]$ sudo mv CA.pem /etc/pki/tls/certs/
[web.tp7.secu@localhost ~]$ sudo chmod 600 /etc/pki/tls/private/web.tp7.secu.key
[web.tp7.secu@localhost ~]$ sudo chmod 644 /etc/pki/tls/certs/web.tp7.secu.crt
```
D. Config serveur Web

🌞 Ajustez la configuration NGINX
```
[web.tp7.secu@localhost ~]$ openssl genrsa -out web.tp7.secu.key 4096
[web.tp7.secu@localhost ~]$ openssl req -new -key web.tp7.secu.key -out web.tp7.secu.csr
You are about to be asked to enter information that will be incorporated
into your certificate request.
What you are about to enter is what is called a Distinguished Name or a DN.
There are quite a few fields but you can leave some blank
For some fields there will be a default value,
If you enter '.', the field will be left blank.
-----
Country Name (2 letter code) [XX]:
State or Province Name (full name) []:
Locality Name (eg, city) [Default City]:
Organization Name (eg, company) [Default Company Ltd]:
Organizational Unit Name (eg, section) []:
Common Name (eg, your name or your server's hostname) []:
Email Address []:

Please enter the following 'extra' attributes
to be sent with your certificate request
A challenge password []:
An optional company name []:
[web.tp7.secu@localhost ~]$ sudo openssl x509 -req -in web.tp7.secu.csr -CA CA.pem -CAkey CA.key -CAcreateserial -out web.tp7.secu.crt -days 500 -sha256 -extfile v3.ext
Certificate request self-signature ok
subject=C = XX, L = Default City, O = Default Company Ltd
Could not open file or uri for loading CA certificate from CA.pem
80BB9070757F0000:error:16000069:STORE routines:ossl_store_get0_loader_int:unregistered scheme:crypto/store/store_register.c:237:scheme=file
80BB9070757F0000:error:80000002:system library:file_open:No such file or directory:providers/implementations/storemgmt/file_store.c:267:calling stat(CA.pem)
Unable to load CA certificate
[web.tp7.secu@localhost ~]$ sudo nano /etc/nginx/sites-available/default
[web.tp7.secu@localhost ~]$ sudo cat /etc/nginx/sites-available/default
server {
    server_name web.tp7.secu;

    listen 10.7.1.103:443 ssl;

    ssl_certificate /etc/pki/tls/certs/web.tp7.secu.crt;
    ssl_certificate_key /etc/pki/tls/private/web.tp7.secu.key;
    
    root /var/www/site_nul;
}
[web.tp7.secu@localhost ~]$ sudo systemctl restart nginx
```
🌞 Prouvez avec un curl que vous accédez au site web
```
[web.tp7.secu@localhost ~]$ curl -k https://web.tp7.secu

<html>
<head><title>Bienvenue sur web.tp7.secu</title></head>
<body>
<h1>Bienvenue sur votre serveur sécurisé</h1>
</body>
</html>
```
🌞 Ajouter le certificat de la CA dans votre navigateur
```
Dans Firefox : Allez dans les paramètres de sécurité et importez le fichier CA.pem de votre CA.
```

E. Bonus renforcement TLS

⭐ Bonus : renforcer la conf TLS
```
ssl_protocols TLSv1.2 TLSv1.3;
ssl_ciphers 'ECDHE-ECDSA-AES256-GCM-SHA384:ECDHE-RSA-AES256-GCM-SHA384:DHE-RSA-AES256-GCM-SHA384';
```