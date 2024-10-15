TP3 SECU : SVP soyez cools

Le jeudi 10 octobre et vendredi 11 octobre 2024 s'est déroulé un TP réseau dans la section cybersécurité se portant sur un scan réseau de tout le campus d'une école. Comme mentionné , il s'agissait uniquement d'un scan pour apprendre à récolter des informations et des données dans une démarche de prise d'information passive et non active, tout cela encadré par un professionnel. Il est à rappeler que ce travail a été réalisé dans un cadre purement pédagogique et qu'il est donc forcément et nécéssairement illégal à refaire ça dans n'importe quel réseau sous peine de sanction pénale sévère et exemplaire. 

Vous retrouverez dans le cadre de ce rapport toutes les informations récoltées point par point ainsi que de potentielles vulnérabilités trouvées à la fin.

À savoir que toutes les informations qui seront déposées dans ce rapoort ont été récoltées étant au rez-de-chausée du batiment, par mesure de discrétion.

- Mon point de départ de cette récolte d'information est logiquement de connaitre mon IP pour ensuite me donner de la matière à travailler pour la suite.

"ifconfig" Avec un résultat étant wlo1 : 10.33.66.94


🌞 Découverte du réseau
```
batman33@BATPC:~$ sudo nmap -sP 10.33.66.0/24 | grep "MAC Address"
MAC Address: 9C:29:76:DC:5E:42 (Intel Corporate)
MAC Address: BA:92:36:4C:E2:35 (Unknown)
MAC Address: 0E:82:F1:1B:7A:0A (Unknown)
MAC Address: 34:B1:EB:F1:6B:08 (Unknown)
MAC Address: 00:D4:9E:ED:B5:61 (Intel Corporate)
MAC Address: 16:E0:7A:C2:E7:EB (Unknown)
MAC Address: EE:1E:90:76:7C:F1 (Unknown)
MAC Address: AE:F3:A3:B3:08:61 (Unknown)
MAC Address: 06:57:81:EF:F9:B8 (Unknown)
MAC Address: A6:FE:EB:3A:FE:8F (Unknown)
MAC Address: 4A:4E:6A:B2:2E:DE (Unknown)
MAC Address: 8C:8D:28:37:5A:B9 (Intel Corporate)
MAC Address: E4:BC:AA:F6:9D:E6 (Unknown)
MAC Address: 3A:52:35:20:E8:B7 (Unknown)
MAC Address: 1A:25:AD:AB:11:8D (Unknown)
MAC Address: B6:D1:9F:8E:E8:68 (Unknown)
MAC Address: 04:EC:D8:63:DA:5D (Intel Corporate)
MAC Address: DC:21:5C:18:2A:FE (Intel Corporate)
MAC Address: F6:48:65:78:B8:EB (Unknown)
MAC Address: E4:B3:18:48:36:68 (Intel Corporate)
MAC Address: 1A:25:15:AD:C9:BD (Unknown)
MAC Address: 8A:DE:21:26:CC:90 (Unknown)
MAC Address: 02:6D:01:04:4C:7D (Unknown)
MAC Address: 58:A0:23:22:85:76 (Intel Corporate)
MAC Address: C4:BD:E5:2D:31:D3 (Intel Corporate)
MAC Address: 4C:1D:96:03:E3:D2 (Intel Corporate)
MAC Address: B0:BE:83:10:8F:B0 (Apple)
MAC Address: 0E:B3:22:1C:3F:7A (Unknown)
```
- Ce résultat du scan me permet d'avoir une vue d'ensemble sur les appareils connectés à mon réseau local afin de repérer les appareils grace à leurs adresses MAC. Il y'a 9 appareils Intel Corporate appartenant certainement à des équipements informatique du batiments tels que des ordinateurs ou des ordinateurs par exemple , après il y'a 18 appareils inconnus et 1 appareil de la marque Apple.

🌞 Les équipements fixes (routeurs, serveurs, PC fixes, etc.)

- Dans un second temps, il fallait identifier les équipements de l'école qui ne bougent pas comme les servers , les ordinateurs ou les routeurs par exemple. Ces équipements ont des ports spécifiques qui sont ouverts.

[L'option -p 22,80 et 443 vont me permettre de scanner uniquement les ports courants et rien d'autre comme les ports SSH , HTTP et HTTPS.]
```
batman33@BATPC:~$ sudo nmap -sS -p 22,80,443 10.33.66.0/24

Starting Nmap 7.93 ( https://nmap.org ) at 2024-10-11 11:09 CEST
Nmap scan report for 10.33.66.24
Host is up (0.019s latency).

PORT    STATE    SERVICE
22/tcp  filtered ssh
80/tcp  filtered http
443/tcp filtered https
MAC Address: 9C:29:76:DC:5E:42 (Intel Corporate)

Nmap scan report for 10.33.66.25
Host is up (0.033s latency).

PORT    STATE  SERVICE
22/tcp  closed ssh
80/tcp  closed http
443/tcp closed https
MAC Address: BA:92:36:4C:E2:35 (Unknown)

Nmap scan report for 10.33.66.26
Host is up (0.077s latency).

PORT    STATE    SERVICE
22/tcp  filtered ssh
80/tcp  filtered http
443/tcp filtered https
MAC Address: 0E:82:F1:1B:7A:0A (Unknown)

Nmap scan report for 10.33.66.27
Host is up (0.055s latency).

PORT    STATE  SERVICE
22/tcp  closed ssh
80/tcp  closed http
443/tcp closed https
MAC Address: 34:B1:EB:F1:6B:08 (Unknown)

Nmap scan report for 10.33.66.28
Host is up (0.0068s latency).

PORT    STATE  SERVICE
22/tcp  closed ssh
80/tcp  closed http
443/tcp closed https
MAC Address: 00:D4:9E:ED:B5:61 (Intel Corporate)

Nmap scan report for 10.33.66.31
Host is up (0.28s latency).

PORT    STATE    SERVICE
22/tcp  filtered ssh
80/tcp  filtered http
443/tcp filtered https
MAC Address: 16:E0:7A:C2:E7:EB (Unknown)

Nmap scan report for 10.33.66.32
Host is up (0.33s latency).

PORT    STATE    SERVICE
22/tcp  filtered ssh
80/tcp  filtered http
443/tcp filtered https
MAC Address: EE:1E:90:76:7C:F1 (Unknown)

Nmap scan report for 10.33.66.33
Host is up (0.021s latency).

PORT    STATE    SERVICE
22/tcp  filtered ssh
80/tcp  filtered http
443/tcp filtered https
MAC Address: AE:F3:A3:B3:08:61 (Unknown)

Nmap scan report for 10.33.66.41
Host is up (0.053s latency).

PORT    STATE  SERVICE
22/tcp  closed ssh
80/tcp  closed http
443/tcp closed https
MAC Address: 06:57:81:EF:F9:B8 (Unknown)

Nmap scan report for 10.33.66.44
Host is up (0.055s latency).

PORT    STATE  SERVICE
22/tcp  closed ssh
80/tcp  open   http
443/tcp closed https
MAC Address: A6:FE:EB:3A:FE:8F (Unknown)

Nmap scan report for 10.33.66.48
Host is up (0.068s latency).

PORT    STATE    SERVICE
22/tcp  filtered ssh
80/tcp  filtered http
443/tcp filtered https
MAC Address: 4A:4E:6A:B2:2E:DE (Unknown)

Nmap scan report for 10.33.66.49
Host is up (0.0037s latency).

PORT    STATE  SERVICE
22/tcp  closed ssh
80/tcp  closed http
443/tcp closed https
MAC Address: 8C:8D:28:37:5A:B9 (Intel Corporate)

Nmap scan report for 10.33.66.51
Host is up (0.33s latency).

PORT    STATE  SERVICE
22/tcp  closed ssh
80/tcp  closed http
443/tcp closed https
MAC Address: E4:BC:AA:F6:9D:E6 (Unknown)

Nmap scan report for 10.33.66.54
Host is up (0.019s latency).

PORT    STATE  SERVICE
22/tcp  closed ssh
80/tcp  closed http
443/tcp closed https
MAC Address: 3A:52:35:20:E8:B7 (Unknown)

Nmap scan report for 10.33.66.59
Host is up (0.025s latency).

PORT    STATE  SERVICE
22/tcp  closed ssh
80/tcp  closed http
443/tcp closed https
MAC Address: 1A:25:AD:AB:11:8D (Unknown)

Nmap scan report for 10.33.66.65
Host is up (0.043s latency).

PORT    STATE  SERVICE
22/tcp  closed ssh
80/tcp  closed http
443/tcp closed https
MAC Address: B6:D1:9F:8E:E8:68 (Unknown)

Nmap scan report for 10.33.66.66
Host is up (0.0045s latency).

PORT    STATE    SERVICE
22/tcp  filtered ssh
80/tcp  filtered http
443/tcp filtered https
MAC Address: 04:EC:D8:63:DA:5D (Intel Corporate)

Nmap scan report for 10.33.66.68
Host is up (0.027s latency).

PORT    STATE  SERVICE
22/tcp  closed ssh
80/tcp  closed http
443/tcp closed https
MAC Address: DC:21:5C:18:2A:FE (Intel Corporate)

Nmap scan report for 10.33.66.75
Host is up (0.58s latency).

PORT    STATE    SERVICE
22/tcp  filtered ssh
80/tcp  filtered http
443/tcp filtered https
MAC Address: F6:48:65:78:B8:EB (Unknown)

Nmap scan report for 10.33.66.78
Host is up (0.061s latency).

PORT    STATE  SERVICE
22/tcp  closed ssh
80/tcp  closed http
443/tcp closed https
MAC Address: E4:B3:18:48:36:68 (Intel Corporate)

Nmap scan report for 10.33.66.104
Host is up (0.38s latency).

PORT    STATE    SERVICE
22/tcp  filtered ssh
80/tcp  filtered http
443/tcp filtered https
MAC Address: 1A:25:15:AD:C9:BD (Unknown)

Nmap scan report for 10.33.66.105
Host is up (0.0051s latency).

PORT    STATE    SERVICE
22/tcp  open     ssh
80/tcp  filtered http
443/tcp filtered https
MAC Address: 8A:DE:21:26:CC:90 (Unknown)

Nmap scan report for 10.33.66.106
Host is up (0.0072s latency).

PORT    STATE  SERVICE
22/tcp  closed ssh
80/tcp  closed http
443/tcp closed https
MAC Address: 02:6D:01:04:4C:7D (Unknown)

Nmap scan report for 10.33.66.108
Host is up (0.043s latency).

PORT    STATE  SERVICE
22/tcp  closed ssh
80/tcp  closed http
443/tcp closed https
MAC Address: 58:A0:23:22:85:76 (Intel Corporate)

Nmap scan report for 10.33.66.112
Host is up (0.033s latency).

PORT    STATE    SERVICE
22/tcp  filtered ssh
80/tcp  filtered http
443/tcp filtered https
MAC Address: C4:BD:E5:2D:31:D3 (Intel Corporate)

Nmap scan report for 10.33.66.113
Host is up (0.0042s latency).

PORT    STATE    SERVICE
22/tcp  filtered ssh
80/tcp  filtered http
443/tcp filtered https
MAC Address: 4C:1D:96:03:E3:D2 (Intel Corporate)

Nmap scan report for 10.33.66.114
Host is up (0.066s latency).

PORT    STATE  SERVICE
22/tcp  closed ssh
80/tcp  closed http
443/tcp closed https
MAC Address: B0:BE:83:10:8F:B0 (Apple)

Nmap scan report for 10.33.66.117
Host is up (0.015s latency).

PORT    STATE  SERVICE
22/tcp  closed ssh
80/tcp  closed http
443/tcp closed https
MAC Address: 0E:B3:22:1C:3F:7A (Unknown)

Nmap scan report for 10.33.66.94
Host is up (0.000031s latency).

PORT    STATE  SERVICE
22/tcp  open   ssh
80/tcp  closed http
443/tcp closed https

Nmap done: 256 IP addresses (29 hosts up) 
```

- À la suite de ces résultats, nous constatons que les machines ayant les ports fermés (SSH, HTTP, HTTPS) semblent etre des ordinteurs fixes ou des périphériques qui ne sont pas accessibles de manière standard. Néanmoins, nous relevons qu'il y'a 2 servers(10.33.66.94, 10.33.66.105) et un server web (10.33.66.44).


🌞 Les bornes WiFi

- Ensuite, nous arrivons à l'étape de trouver les bornes WiFi. Pour cela, j'ai utilisé la command aircrack-ng pour identifier et analyser les bornes. Avec cette commande, nous pouvons obtenir des informations comme l'adresse MAC (BSSID) , la puissance du signal (PWR), le canal utilisé (CH), le type de chiffrement (WEP, WPA...), et le nombre de clients connectés (STATION). Airmon-ng ou airodump-ng peuvent servir à la détection des vulnérabilitéés ou au suivi et surveillance de ces bornes, mais cela ne fait pas parti du cadre légal de ce travail réalisé au sein de l'école.

- Pour pouvoir mener à bien cette récolte d'information avec la commande airmon-ng, il fallait d'abord se mettre en monitor avec la commande "sudo airmon-ng start wlo1", une fois que l'ordinateur a basculé en mode monitor :
```
batman33@BATPC:~$ sudo airmon-ng start wlo1

Found 4 processes that could cause trouble.
 CH  8 ][ Elapsed: 2 mins ][ 2024-10-11 11:06 ][ WPA handshake: E8:10:98:99:A8:00 

 BSSID              PWR  Beacons    #Data, #/s  CH   MB   ENC CIPHER  AUTH ESSID

 E8:10:98:99:A9:B0   -1        0        0    0  -1   -1                    <length:  0>                                                                                                                           
 E8:10:98:99:66:E2  -38        1        0    0  11  260   WPA3 CCMP   SAE  HUB@YNOV                                                                                                                               
 A6:77:1E:D8:B8:E2  -33       15        3    0   6  130   WPA2 CCMP   PSK  Adnane’s iPhone                                                                                                                      
 E8:10:98:99:0B:20   -1        0        3    0   6   -1   WPA              <length:  0>                                                                                                                           
 E8:10:98:99:EE:06  -32       60        0    0   6  260   WPA3 CCMP   SAE  ROBOT@YNOV                                                                                                                             
 E8:10:98:99:EE:05  -33       64        0    0   6  260   WPA2 CCMP   PSK  ROKOKO                                                                                                                                 
 E8:10:98:99:EE:04  -34       68        0    0   6  260   WPA3 CCMP   OWE  <length:  0>                                                                                                                           
 E8:10:98:99:EE:03  -22       61        0    0   6  260   OPN              INVIT@YNOV                                                                                                                             
 E8:10:98:99:EE:02  -32       59        0    0   6  260   WPA3 CCMP   SAE  HUB@YNOV                                                                                                                               
 E8:10:98:99:EE:01  -33       61        0    0   6  260   WPA3 CCMP   SAE  VDI@YNOV                                                                                                                               
 E8:10:98:99:EE:00  -88       62       88    1   6  260   WPA2 CCMP   MGT  WiFi@YNOV                                                                                                                              
 E8:10:98:99:A9:A6  -10      107        0    0  11  260   WPA3 CCMP   SAE  ROBOT@YNOV                                                                                                                             
 E8:10:98:99:A9:A5   -9      100        0    0  11  260   WPA2 CCMP   PSK  ROKOKO                                                                                                                                 
 E8:10:98:99:A9:A4  -10      104        0    0  11  260   WPA3 CCMP   OWE  <length:  0>                                                                                                                           
 E8:10:98:99:A9:A3  -10      101        0    0  11  260   OPN              INVIT@YNOV                                                                                                                             
 E8:10:98:99:A9:A2  -10      106        0    0  11  260   WPA3 CCMP   SAE  HUB@YNOV                                                                                                                               
 E8:10:98:99:A9:A1  -11      104        0    0  11  260   WPA3 CCMP   SAE  VDI@YNOV                                                                                                                               
 E8:10:98:99:A9:A0  -10      113      105    5  11  260   WPA2 CCMP   MGT  WiFi@YNOV                                                                                                                              
 E8:10:98:99:A8:04  -16       81        0    0   1  260   WPA3 CCMP   OWE  <length:  0>                                                                                                                           
 E8:10:98:99:A8:05  -18       87        0    0   1  260   WPA2 CCMP   PSK  ROKOKO                                                                                                                                 
 E8:10:98:99:A8:03  -16       81        0    0   1  260   OPN              INVIT@YNOV                                                                                                                             
 E8:10:98:99:A8:06  -16       88        0    0   1  260   WPA3 CCMP   SAE  ROBOT@YNOV                                                                                                                             
 E8:10:98:99:A8:02  -17       88        0    0   1  260   WPA3 CCMP   SAE  HUB@YNOV                                                                                                                               
 E8:10:98:99:A8:01  -17       91        0    0   1  260   WPA3 CCMP   SAE  VDI@YNOV                                                                                                                               
 E8:10:98:99:A8:00  -16       92       91    0   1  260   WPA2 CCMP   MGT  WiFi@YNOV                                                                                                                              

 BSSID              STATION            PWR   Rate    Lost    Frames  Notes  Probes

 E8:10:98:99:66:E2  50:8B:B9:51:5D:78  -92    0 - 1      0        2                                                                                                                                                
 A6:77:1E:D8:B8:E2  AE:7E:F4:04:5E:CB  -79    0 -24      0       12         Adnane’s iPhone                                                                                                                      
 E8:10:98:99:0B:20  C2:B9:5B:D6:90:9E  -86    0 - 1      0       63         WiFi@YNOV                                                                                                                              
 E8:10:98:99:0B:20  56:D3:E2:B7:79:FB  -67    0 -24      0        6         WiFi@YNOV                                                                                                                              
 E8:10:98:99:0B:20  DA:DD:99:51:DE:32  -89    0 - 1      0       24         WiFi@YNOV                                                                                                                              
 E8:10:98:99:EE:00  FA:91:6A:56:CA:EE   -1    1e- 0      0       11                                                                                                                                                
 E8:10:98:99:EE:00  26:1C:96:CD:94:92  -81    1e-24e     0       11  EAPOL  WiFi@YNOV                                                                                                                              
 E8:10:98:99:A9:A0  B2:CE:58:EC:15:B2  -91    1e- 1      0       39                                                                                                                                                
 E8:10:98:99:A9:A0  E2:C9:D6:9D:7B:01  -82    1e- 1      0       12         WiFi@YNOV                                                                                                                              
 E8:10:98:99:A9:A0  4E:07:B3:80:06:EE  -88    1e- 6e     0       57   
```
- Nous nous apercevons qu'il ya 24 bornes WiFi, une information relevée depuis le rez-de-chausée du batiment.        


🌞 Emplacement physique de la salle server

Emplacement de la Salle Serveur :

La salle serveur est située au deuxième étage du bâtiment au milieu des salles 205 et 201 au fond du couloir à gauche de la sortie du premier escalier ou il y'a les distributeurs , sinon à droite en prenant les deuxièmes escaliers ou il y'a le plan de l'école. L'accès à cette salle est strictement limité au personnel autorisé. Aucune entrée n'est permise sans autorisation. 

PS : Aucune tentative physique d'y pénétrer n'a été réalisé, aucune demande de visite de cette salle a été faite également auprès de l'adminstrateur réseau de l'école. Ni aucun scan pour récolter des informations dans cette salle n'a été effectué. 


🌞 Les périphériques réseau
```
batman33@BATPC:~$ sudo nmap -sP 10.33.64.0/20
Starting Nmap 7.93 ( https://nmap.org ) at 2024-10-14 08:24 CEST
Nmap scan report for 10.33.65.108
Host is up (0.021s latency).
MAC Address: 02:61:67:DC:76:81 (Unknown)
Nmap scan report for 10.33.66.25
Host is up (0.089s latency).
MAC Address: BA:92:36:4C:E2:35 (Unknown)
Nmap scan report for 10.33.66.148
Host is up (3.4s latency).
MAC Address: FA:9C:7D:C2:CA:7F (Unknown)
Nmap scan report for 10.33.67.115
Host is up (0.033s latency).
MAC Address: CA:85:A8:47:00:4B (Unknown)
Nmap scan report for 10.33.67.118
Host is up (0.68s latency).
MAC Address: 7C:F3:4D:DC:EE:80 (Unknown)
Nmap scan report for 10.33.67.119
Host is up (0.090s latency).
MAC Address: 60:6E:E8:2A:8F:90 (Xiaomi Communications)
Nmap scan report for 10.33.68.156
Host is up (0.71s latency).
MAC Address: 1E:78:CF:18:A1:0D (Unknown)
Nmap scan report for 10.33.70.42
Host is up (0.0038s latency).
MAC Address: 9C:FC:E8:42:F1:7B (Intel Corporate)
Nmap scan report for 10.33.72.92
Host is up (0.0051s latency).
MAC Address: 56:96:18:4C:10:2A (Unknown)
Nmap scan report for 10.33.73.50
Host is up (0.0031s latency).
MAC Address: 28:6B:35:F2:3E:24 (Intel Corporate)
Nmap scan report for 10.33.73.159
Host is up (0.079s latency).
MAC Address: FE:92:CC:26:0E:B3 (Unknown)
Nmap scan report for 10.33.73.199
Host is up (0.0038s latency).
MAC Address: 30:89:4A:0F:4F:1A (Intel Corporate)
Nmap scan report for 10.33.73.215
Host is up (0.0053s latency).
MAC Address: FE:36:07:84:07:9F (Unknown)
Nmap scan report for 10.33.74.33
Host is up (0.016s latency).
MAC Address: 58:96:71:9D:11:1E (Unknown)
Nmap scan report for 10.33.74.35
Host is up (0.0045s latency).
MAC Address: D4:E9:8A:D0:B6:19 (Intel Corporate)
Nmap scan report for 10.33.74.36
Host is up (0.015s latency).
MAC Address: 68:34:21:EA:E0:2F (Unknown)
Nmap scan report for 10.33.74.73
Host is up (0.026s latency).
MAC Address: 36:0B:1D:7C:95:E5 (Unknown)
Nmap scan report for 10.33.74.115
Host is up (0.011s latency).
MAC Address: B2:EE:F7:B5:85:94 (Unknown)
Nmap scan report for 10.33.75.3
Host is up (0.39s latency).
MAC Address: D6:BC:96:EA:E2:91 (Unknown)
Nmap scan report for 10.33.76.9
Host is up (0.039s latency).
MAC Address: 2A:E2:E3:87:FC:51 (Unknown)
Nmap scan report for 10.33.76.13
Host is up (0.0050s latency).
MAC Address: E2:6A:AB:AB:03:27 (Unknown)
Nmap scan report for 10.33.76.57
Host is up (0.57s latency).
MAC Address: 8E:83:32:FD:DD:4B (Unknown)
Nmap scan report for 10.33.76.97
Host is up (0.061s latency).
MAC Address: B2:6F:0B:BB:F5:0D (Unknown)
Nmap scan report for 10.33.76.105
Host is up (0.55s latency).
MAC Address: AA:4B:2E:46:10:DF (Unknown)
Nmap scan report for 10.33.76.154
Host is up (0.098s latency).
MAC Address: BE:14:D4:B6:BB:78 (Unknown)
Nmap scan report for 10.33.77.24
Host is up (1.1s latency).
MAC Address: 02:17:57:68:08:03 (Unknown)
Nmap scan report for 10.33.77.30
Host is up (0.026s latency).
MAC Address: E4:60:17:40:55:6A (Intel Corporate)
Nmap scan report for 10.33.77.80
Host is up (0.92s latency).
MAC Address: 42:7F:C1:8D:7C:AA (Unknown)
Nmap scan report for 10.33.77.82
Host is up (0.085s latency).
MAC Address: D8:80:83:D0:D6:EB (Cloud Network Technology Singapore PTE.)
Nmap scan report for 10.33.77.111
Host is up (0.0043s latency).
MAC Address: D0:65:78:4C:BF:08 (Unknown)
Nmap scan report for 10.33.77.168
Host is up (0.15s latency).
MAC Address: 3E:4D:A2:6D:37:1D (Unknown)
Nmap scan report for 10.33.77.230
Host is up (0.086s latency).
MAC Address: 18:93:41:86:FE:16 (Unknown)
Nmap scan report for 10.33.77.236
Host is up (0.12s latency).
MAC Address: 6C:2F:80:B5:1B:E8 (Unknown)
Nmap scan report for 10.33.78.117
Host is up (0.39s latency).
MAC Address: 68:CA:C4:99:4C:7B (Unknown)
Nmap scan report for 10.33.78.124
Host is up (0.090s latency).
MAC Address: 56:D4:D9:CF:F5:A5 (Unknown)
Nmap scan report for 10.33.78.130
Host is up (0.073s latency).
MAC Address: 3A:14:36:51:6E:2D (Unknown)
Nmap scan report for 10.33.78.141
Host is up (0.031s latency).
MAC Address: 4C:D5:77:E5:91:9D (Chongqing Fugui Electronics)
Nmap scan report for 10.33.78.142
Host is up (0.020s latency).
MAC Address: 28:16:AD:E0:CF:81 (Intel Corporate)
Nmap scan report for 10.33.78.150
Host is up (0.0055s latency).
MAC Address: 7C:21:4A:E8:11:1A (Intel Corporate)
Nmap scan report for 10.33.78.151
Host is up (0.0063s latency).
MAC Address: 80:65:7C:D6:8A:A3 (Apple)
Nmap scan report for 10.33.78.153
Host is up (0.10s latency).
MAC Address: B2:D9:6C:00:48:67 (Unknown)
Nmap scan report for 10.33.78.155
Host is up (0.037s latency).
MAC Address: 28:C5:D2:67:28:89 (Intel Corporate)
Nmap scan report for 10.33.78.157
Host is up (0.45s latency).
MAC Address: E6:9F:D1:5D:BB:A6 (Unknown)
Nmap scan report for 10.33.78.159
Host is up (0.061s latency).
MAC Address: 30:F6:EF:E6:AD:98 (Intel Corporate)
Nmap scan report for 10.33.78.160
Host is up (0.064s latency).
MAC Address: 14:7D:DA:BF:E0:D6 (Apple)
Nmap scan report for 10.33.78.163
Host is up (0.070s latency).
MAC Address: 1A:8E:B5:98:77:38 (Unknown)
Nmap scan report for 10.33.78.166
Host is up (0.0066s latency).
MAC Address: D0:65:78:37:D6:29 (Unknown)
Nmap scan report for 10.33.78.168
Host is up (0.0060s latency).
MAC Address: 60:3E:5F:5A:B2:43 (Unknown)
Nmap scan report for 10.33.78.171
Host is up (0.0046s latency).
MAC Address: A4:83:E7:75:7C:78 (Apple)
Nmap scan report for 10.33.78.173
Host is up (0.026s latency).
MAC Address: 5E:9E:B6:64:C4:52 (Unknown)
Nmap scan report for 10.33.78.174
Host is up (0.0045s latency).
MAC Address: CA:00:68:9A:3C:0A (Unknown)
Nmap scan report for 10.33.78.186
Host is up (0.61s latency).
MAC Address: 7C:F3:4D:E5:FA:EE (Unknown)
Nmap scan report for 10.33.78.199
Host is up (0.051s latency).
MAC Address: 22:4A:62:58:A0:03 (Unknown)
Nmap scan report for 10.33.78.202
Host is up (0.17s latency).
MAC Address: DA:9D:30:21:F2:5C (Unknown)
Nmap scan report for 10.33.78.234
Host is up (0.17s latency).
MAC Address: 34:6F:24:E2:DA:27 (AzureWave Technology)
Nmap scan report for 10.33.78.247
Host is up (0.57s latency).
MAC Address: 36:1B:3B:A0:6B:40 (Unknown)
Nmap scan report for 10.33.79.115
Host is up (0.56s latency).
MAC Address: 72:90:60:02:33:B5 (Unknown)
Nmap scan report for 10.33.79.254
Host is up (0.0017s latency).
MAC Address: 7C:5A:1C:D3:D8:76 (Sophos)
Nmap scan report for 10.33.66.94
Host is up.
Nmap done: 4096 IP addresses (59 hosts up) scanned in 94.71 seconds
```
-  Ce scan effectué sur la plage d'adresses 10.33.66.0./20 a pu me détecter 59 hotes pour 4096 adresses IP trouvées. La majorité des appareils trouvés n'ont pas pu etre identifié. Néanmoins, quelques constructeurs ont pu etre relevés comme Intel Corporate, AsureWave Technology , Apple, Xiaomi,Cloud Network Technology Singapore PTE ou Sophos.


🌞 Détection des appareils non joignables ou joignables
```
batman33@BATPC:~$ sudo arp-scan --interface=wlo1 10.33.66.0/24
Interface: wlo1, type: EN10MB, MAC: 34:c9:3d:22:bb:b9, IPv4: 10.33.66.94
WARNING: Cannot open MAC/Vendor file ieee-oui.txt: Permission denied
WARNING: Cannot open MAC/Vendor file mac-vendor.txt: Permission denied
Starting arp-scan 1.10.0 with 256 hosts (https://github.com/royhills/arp-scan)
10.33.66.25	ba:92:36:4c:e2:35	(Unknown: locally administered)
10.33.66.153	a4:cf:99:6e:e6:be	(Unknown)
10.33.66.151	42:b8:3a:4d:4c:9d	(Unknown: locally administered)
10.33.66.150	1a:19:54:62:fc:44	(Unknown: locally administered)
10.33.66.148	fa:9c:7d:c2:ca:7f	(Unknown: locally administered)
10.33.66.152	1e:3b:18:99:a2:fd	(Unknown: locally administered)

7 packets received by filter, 0 packets dropped by kernel
Ending arp-scan 1.10.0: 256 hosts scanned in 1.859 seconds (137.71 hosts/sec). 6 responded
```
- Suite à ce résultat avec arp-scan , nous pouvons remarquer qu'il y'a 5 appareils avec une adresse MAC inconnue. Je suppose que les 4 appareils avec le commentaire "Unknown locally administred" ont des adresses mac auto-assignée ou ont été configuré manuellement, ce sont peut-etre des des VM (machines virtuelles) ou un appareil ayant une configuration réseau particulière.

🌞 Détection des LANs joignables ou isolés
```
batman33@BATPC:~$ sudo arp-scan --localnet
[sudo] Mot de passe de batman33 : 
Interface: wlo1, type: EN10MB, MAC: 34:c9:3d:22:bb:b9, IPv4: 10.33.66.94
WARNING: Cannot open MAC/Vendor file ieee-oui.txt: Permission denied
WARNING: Cannot open MAC/Vendor file mac-vendor.txt: Permission denied
Starting arp-scan 1.10.0 with 4096 hosts (https://github.com/royhills/arp-scan)
10.33.64.1	    18:47:3d:85:5f:b9	(Unknown)
10.33.64.26    	f0:57:a6:d2:8a:02	(Unknown)
10.33.64.173	0a:5f:bf:9c:c3:10	(Unknown: locally administered)
10.33.64.159	b6:a4:05:1e:f7:90	(Unknown: locally administered)
10.33.64.199	e4:c7:67:7b:7e:c9	(Unknown)
10.33.65.17	    78:af:08:06:dd:08	(Unknown)
10.33.64.212	26:13:15:15:5d:a5	(Unknown: locally administered)
10.33.64.229	da:dd:99:51:de:32	(Unknown: locally administered)
10.33.64.222	76:40:b6:9f:08:cc	(Unknown: locally administered)
10.33.65.93	    f4:26:79:a4:97:ff	(Unknown)
10.33.65.111	9c:58:84:1f:bb:7e	(Unknown)
10.33.65.73	    a0:02:a5:a2:1d:9a	(Unknown)
10.33.65.96	    94:bb:43:99:25:0b	(Unknown)
10.33.65.108	02:61:67:dc:76:81	(Unknown: locally administered)
10.33.64.216	de:bb:4d:3f:f3:50	(Unknown: locally administered)
10.33.65.210	2c:33:58:72:52:ae	(Unknown)
10.33.65.212	14:85:7f:b6:c7:d6	(Unknown)
10.33.66.28  	00:d4:9e:ed:b5:61	(Unknown)
10.33.66.39	    d8:44:89:5b:f4:c1	(Unknown)
10.33.66.41	    06:57:81:ef:f9:b8	(Unknown: locally administered)
10.33.66.25	    ba:92:36:4c:e2:35	(Unknown: locally administered)
10.33.66.27	    34:b1:eb:f1:6b:08	(Unknown)
10.33.66.33	    ae:f3:a3:b3:08:61	(Unknown: locally administered)
10.33.66.52	    50:e0:85:12:bb:aa	(Unknown)
10.33.66.73	    36:9f:cf:df:dc:a4	(Unknown: locally administered)
10.33.66.48	    4a:4e:6a:b2:2e:de	(Unknown: locally administered)
10.33.78.150	7c:21:4a:e8:11:1a	(Unknown)
10.33.72.230	8c:17:59:dc:f8:f2	(Unknown)
10.33.72.192	44:e5:17:07:1b:24	(Unknown)
10.33.66.29	    da:2e:0d:c4:76:d8	(Unknown: locally administered)
10.33.64.219	ee:95:c8:b8:35:72	(Unknown: locally administered)
10.33.66.133	50:a6:d8:cf:60:89	(Unknown)
10.33.66.141	00:a5:54:c6:91:d4	(Unknown)
10.33.66.140	00:41:0e:2b:91:5d	(Unknown)
10.33.66.78	    e4:b3:18:48:36:68	(Unknown)
10.33.66.103	fa:0d:e7:80:65:0a	(Unknown: locally administered)
10.33.66.108	58:a0:23:22:85:76	(Unknown)
10.33.66.157	02:05:6d:f9:94:3d	(Unknown: locally administered)
10.33.66.163	44:fa:66:96:59:c7	(Unknown)
10.33.66.167	b2:13:a8:c2:cd:6b	(Unknown: locally administered)
10.33.66.147	90:e8:68:15:ac:43	(Unknown)
10.33.66.171	ac:29:3a:e9:eb:e4	(Unknown)
10.33.66.161	e4:60:17:40:68:02	(Unknown)
10.33.66.156	c8:89:f3:b0:3f:a4	(Unknown)
10.33.66.153	a4:cf:99:6e:e6:be	(Unknown)
10.33.66.159	5e:e2:9e:39:da:ef	(Unknown: locally administered)
10.33.66.173	12:cf:fb:82:b1:7e	(Unknown: locally administered)
10.33.66.187	10:b1:df:76:40:dd	(Unknown)
10.33.66.148	fa:9c:7d:c2:ca:7f	(Unknown: locally administered)
10.33.66.177	8c:85:90:94:ec:14	(Unknown)
10.33.66.178	36:20:1e:33:07:f6	(Unknown: locally administered)
10.33.66.197	92:0a:72:f8:40:13	(Unknown: locally administered)
10.33.66.190	30:d1:6b:9a:08:1b	(Unknown)
10.33.66.202	56:18:5e:ad:6a:83	(Unknown: locally administered)
10.33.66.205	82:d5:10:07:ba:62	(Unknown: locally administered)
10.33.66.203	ea:04:99:dc:90:96	(Unknown: locally administered)
10.33.66.204	ee:20:a1:c5:2f:31	(Unknown: locally administered)
10.33.66.200	22:7f:55:63:90:93	(Unknown: locally administered)
10.33.66.206	14:ab:c5:e3:89:97	(Unknown)
10.33.66.193	7e:ec:d5:3b:4a:6a	(Unknown: locally administered)
10.33.66.194	b2:58:4f:7d:91:61	(Unknown: locally administered)
10.33.66.120	60:ab:67:d6:30:db	(Unknown)
10.33.66.172	10:b1:df:68:7d:87	(Unknown)
10.33.66.199	ae:cc:68:89:f0:e5	(Unknown: locally administered)
10.33.66.185	5e:49:7f:11:64:ab	(Unknown: locally administered)
10.33.66.160	aa:1b:93:73:7a:29	(Unknown: locally administered)
10.33.66.186	5a:ca:b8:74:c3:38	(Unknown: locally administered)
10.33.66.164	96:fe:cb:6b:a3:e3	(Unknown: locally administered)
10.33.66.117	0e:b3:22:1c:3f:7a	(Unknown: locally administered)
10.33.66.142	02:0a:49:87:08:f8	(Unknown: locally administered)
10.33.66.151	42:b8:3a:4d:4c:9d	(Unknown: locally administered)
10.33.66.166	8a:ba:4c:32:88:b6	(Unknown: locally administered)
10.33.66.158	c8:89:f3:b3:19:b7	(Unknown)
10.33.67.115	ca:85:a8:47:00:4b	(Unknown: locally administered)
10.33.66.61	    2e:f4:ac:2b:97:8a	(Unknown: locally administered)
10.33.66.32	    ee:1e:90:76:7c:f1	(Unknown: locally administered)
10.33.67.127	38:d5:7a:73:89:7d	(Unknown)
10.33.67.135	c2:ed:65:07:20:35	(Unknown: locally administered)
10.33.67.118	7c:f3:4d:dc:ee:80	(Unknown)
10.33.67.119	60:6e:e8:2a:8f:90	(Unknown)
10.33.67.166	6c:7e:67:d5:83:05	(Unknown)
10.33.67.150	5e:e2:fb:63:91:a1	(Unknown: locally administered)
10.33.67.129	76:d5:7a:e7:9b:13	(Unknown: locally administered)
10.33.67.140	4c:e0:db:14:83:51	(Unknown)
10.33.67.164	6c:7e:67:d9:3d:4d	(Unknown)
10.33.67.132	46:d6:85:de:2c:ce	(Unknown: locally administered)
10.33.66.181	42:6a:c2:3d:0c:e0	(Unknown: locally administered)
10.33.67.174	f2:39:c5:c0:07:e5	(Unknown: locally administered)
10.33.67.163	7e:d6:6c:25:bc:f0	(Unknown: locally administered)
10.33.67.179	9e:0e:1e:54:86:16	(Unknown: locally administered)
10.33.67.188	f6:a0:dc:38:cf:17	(Unknown: locally administered)
10.33.67.189	d2:e5:f3:60:de:1a	(Unknown: locally administered)
10.33.66.152	1e:3b:18:99:a2:fd	(Unknown: locally administered)
10.33.67.254	bc:03:58:ae:06:7d	(Unknown)
10.33.68.12	    54:14:f3:ff:a9:79	(Unknown)
10.33.68.1	    f8:4d:89:7f:fd:17	(Unknown)
10.33.67.162	2a:70:10:42:4a:7d	(Unknown: locally administered)
10.33.68.15	    a0:59:50:ea:9e:7b	(Unknown)
10.33.67.252	4c:03:4f:f3:00:ca	(Unknown)
10.33.67.159	ee:1c:9a:a3:1c:f5	(Unknown: locally administered)
10.33.64.193	e2:3f:55:5e:69:3f	(Unknown: locally administered)
10.33.67.167	e6:f7:88:57:a9:4d	(Unknown: locally administered)
10.33.68.23	    e0:c2:64:b2:fb:ce	(Unknown)
10.33.68.21	    f8:b5:4d:43:7c:09	(Unknown)
10.33.66.168	0e:0b:40:e6:c9:ad	(Unknown: locally administered)
10.33.66.188	c8:89:f3:e6:64:0b	(Unknown)
10.33.66.175	82:04:d1:04:81:c5	(Unknown: locally administered)
10.33.67.184	30:f6:ef:7a:c3:12	(Unknown)
10.33.68.42	    38:d5:7a:be:bc:07	(Unknown)
10.33.68.47	    d0:88:0c:7d:8b:4f	(Unknown)
10.33.68.33	    10:68:38:36:84:13	(Unknown)
10.33.68.37	    14:13:33:68:8b:c7	(Unknown)
10.33.68.32	    10:68:38:0a:6a:5b	(Unknown)
10.33.66.196	b2:67:3a:b4:e6:6e	(Unknown: locally administered)
10.33.68.25	    ac:74:b1:56:6d:ff	(Unknown)
10.33.68.16	    54:6c:eb:f5:85:5c	(Unknown)
10.33.68.30	    c4:75:ab:57:92:61	(Unknown)
10.33.68.57	    50:eb:71:a9:a7:ea	(Unknown)
10.33.66.195	c0:95:6d:25:fa:27	(Unknown)
10.33.68.75	    ba:3e:a2:2d:14:6d	(Unknown: locally administered)
10.33.68.112	88:e9:fe:75:94:10	(Unknown)
10.33.68.112	88:e9:fe:75:94:10	(Unknown) (DUP: 2)
10.33.68.95	    32:f7:96:18:9b:34	(Unknown: locally administered)
10.33.68.122	f4:6d:3f:98:bd:ae	(Unknown)
10.33.68.127	60:f2:62:d2:d8:1d	(Unknown)
10.33.66.191	3a:59:ab:d0:68:23	(Unknown: locally administered)
10.33.68.114	56:e4:82:94:89:cf	(Unknown: locally administered)
10.33.68.153	1c:ce:51:93:e7:a4	(Unknown)
10.33.68.129	62:88:47:d2:78:74	(Unknown: locally administered)
10.33.68.177	36:3b:44:4b:96:08	(Unknown: locally administered)
10.33.68.218	b4:0e:de:9a:36:1b	(Unknown)
10.33.68.45	    46:1e:62:cf:47:2b	(Unknown: locally administered)
10.33.67.121	d6:88:21:fe:6b:95	(Unknown: locally administered)
10.33.67.133	6a:04:59:48:98:70	(Unknown: locally administered)
10.33.66.201	5e:8d:d0:72:fe:38	(Unknown: locally administered)
10.33.66.182	f4:d4:88:7c:e3:1e	(Unknown)
10.33.68.128	aa:1c:e7:e4:8e:67	(Unknown: locally administered)
10.33.68.249	70:d8:23:b8:3f:aa	(Unknown)
10.33.68.250	70:d8:23:b8:3f:a8	(Unknown)
10.33.69.0	    10:68:38:5c:ca:a3	(Unknown)
10.33.68.254	9c:b6:d0:05:18:db	(Unknown)
10.33.69.1	    88:ce:43:20:fa:36	(Unknown)
10.33.69.2	    10:f6:0a:84:9f:72	(Unknown)
10.33.68.235	52:4a:23:84:f8:6b	(Unknown: locally administered)
10.33.68.34	    e0:d4:64:77:82:ab	(Unknown)
10.33.66.162	a0:78:17:7c:d8:05	(Unknown)
10.33.67.146	e6:3a:3d:0f:ae:38	(Unknown: locally administered)
10.33.69.8	    2c:3b:70:6e:4c:0f	(Unknown)
10.33.68.156	1e:78:cf:18:a1:0d	(Unknown: locally administered)
10.33.66.183	e0:33:8e:73:70:d3	(Unknown)
10.33.67.173	de:6b:c1:e3:bb:96	(Unknown: locally administered)
10.33.66.189	c8:89:f3:b6:be:3b	(Unknown)
10.33.67.143	72:77:03:19:63:a3	(Unknown: locally administered)
10.33.68.43	    fa:91:6a:56:ca:ee	(Unknown: locally administered)
10.33.69.68	    ee:e8:d9:89:3f:f1	(Unknown: locally administered)
10.33.68.31	    20:c1:9b:af:51:5e	(Unknown)
10.33.67.170	2e:2c:6e:73:56:92	(Unknown: locally administered)
10.33.69.48	    e6:c7:a6:1c:4c:a4	(Unknown: locally administered)
10.33.67.144	e6:18:a5:76:3d:3c	(Unknown: locally administered)
10.33.69.208	30:89:4a:0d:da:8b	(Unknown)
10.33.68.49	    f8:ff:c2:24:c5:59	(Unknown)
10.33.69.232	3c:06:30:3b:b5:3c	(Unknown)
10.33.69.157	3a:71:a3:b0:d6:76	(Unknown: locally administered)
10.33.69.233	7e:26:33:d1:52:b4	(Unknown: locally administered)
10.33.69.246	72:0e:73:e0:8b:ce	(Unknown: locally administered)
10.33.70.42	    9c:fc:e8:42:f1:7b	(Unknown)
10.33.69.235	e2:fd:21:08:7e:46	(Unknown: locally administered)
10.33.67.160	12:0b:96:32:c1:35	(Unknown: locally administered)
10.33.70.76	    10:b1:df:75:d5:2f	(Unknown)
10.33.70.91	    14:5a:fc:89:2d:9f	(Unknown)
10.33.70.101	14:13:33:82:6f:bf	(Unknown)
10.33.70.92	    3a:21:2f:9d:2e:9b	(Unknown: locally administered)
10.33.69.87	    18:3e:ef:e6:20:30	(Unknown)
10.33.70.143	4c:03:4f:e3:dc:c6	(Unknown)
10.33.70.151	30:89:4a:0d:be:7a	(Unknown)
10.33.68.19	    60:3e:5f:89:cf:a6	(Unknown)
10.33.70.114	ee:15:a5:8e:44:27	(Unknown: locally administered)
10.33.70.225	60:dd:8e:74:19:90	(Unknown)
10.33.70.254	e4:0d:36:2a:51:ed	(Unknown)
10.33.68.22	    46:2b:a3:e5:61:c3	(Unknown: locally administered)
10.33.69.13	    02:d0:e8:56:ac:a3	(Unknown: locally administered)
10.33.71.19	    52:9c:ea:17:34:2d	(Unknown: locally administered)
10.33.71.53	    9a:f6:97:4a:f3:d1	(Unknown: locally administered)
10.33.71.108	dc:97:ba:c9:9a:87	(Unknown)
10.33.71.58	    d0:88:0c:a4:51:2d	(Unknown)
10.33.71.117	1c:bf:c0:6d:5d:09	(Unknown)
10.33.71.82	    8c:7a:3d:de:08:9c	(Unknown)
10.33.71.88	    36:c5:da:db:d7:28	(Unknown: locally administered)
10.33.71.104	4a:9b:a8:d4:72:fc	(Unknown: locally administered)
10.33.70.144	b0:68:e6:bc:ef:e3	(Unknown)
10.33.71.99	    74:15:75:54:eb:4b	(Unknown)
10.33.71.142	f2:19:a3:48:f6:32	(Unknown: locally administered)
10.33.71.156	fa:f1:d8:3f:f4:cf	(Unknown: locally administered)
10.33.71.100	e2:3e:74:cb:e6:b5	(Unknown: locally administered)
10.33.71.85	    7e:db:90:24:f4:b8	(Unknown: locally administered)
10.33.71.101	de:da:10:e6:0e:be	(Unknown: locally administered)
10.33.71.235	b2:50:3f:fc:6c:8a	(Unknown: locally administered)
10.33.71.243	92:ed:ee:5e:a0:34	(Unknown: locally administered)
10.33.72.21	    c6:58:fd:e0:e7:75	(Unknown: locally administered)
10.33.72.38	    36:63:8d:a3:02:17	(Unknown: locally administered)
10.33.71.11	    52:b4:cd:d8:7d:11	(Unknown: locally administered)
10.33.72.92	    56:96:18:4c:10:2a	(Unknown: locally administered)
10.33.72.93	    94:bb:43:1c:49:2f	(Unknown)
10.33.72.41	    a4:c6:f0:2d:0d:98	(Unknown)
10.33.72.78	    7c:f3:4d:eb:af:84	(Unknown)
10.33.71.91	    f6:46:e4:2e:f6:4f	(Unknown: locally administered)
10.33.72.142	54:6c:eb:7c:6d:16	(Unknown)
10.33.72.148	8c:f8:c5:0e:69:c4	(Unknown)
10.33.72.150	92:d5:3b:f5:79:f5	(Unknown: locally administered)
10.33.72.151	e0:2e:0b:df:2e:38	(Unknown)
10.33.72.141	5e:68:aa:2c:f4:11	(Unknown: locally administered)
10.33.72.28	    ba:c7:ee:e4:43:a1	(Unknown: locally administered)
10.33.72.164	84:7b:57:f3:5c:7d	(Unknown)
10.33.72.167	10:68:38:f9:61:f8	(Unknown)
10.33.72.139	e0:b5:5f:eb:3c:e7	(Unknown)
10.33.72.169	b4:8c:9d:04:10:21	(Unknown)
10.33.72.170	b4:8c:9d:44:3a:f5	(Unknown)
10.33.72.172	a0:29:42:24:b0:3f	(Unknown)
10.33.72.174	3c:a6:f6:03:e6:53	(Unknown)
10.33.72.173	3c:6a:a7:c7:2b:d5	(Unknown)
10.33.72.195	c8:96:65:d6:f7:dd	(Unknown)
10.33.72.179	6a:60:e9:76:ce:93	(Unknown: locally administered)
10.33.72.116	16:70:8a:d9:27:dc	(Unknown: locally administered)
10.33.72.204	80:b6:55:10:c4:94	(Unknown)
10.33.72.193	34:f3:9a:b9:00:d7	(Unknown)
10.33.72.102	ea:78:d0:f5:49:23	(Unknown: locally administered)
10.33.72.152	da:1f:8f:e6:09:ba	(Unknown: locally administered)
10.33.72.209	e8:fb:1c:a2:68:ef	(Unknown)
10.33.72.157	c8:cb:9e:ee:d9:a0	(Unknown)
10.33.72.208	70:d8:23:73:95:9c	(Unknown)
10.33.72.213	28:39:26:a2:7a:71	(Unknown)
10.33.72.215	60:e9:aa:ca:46:f7	(Unknown)
10.33.72.225	64:d6:9a:e8:55:6c	(Unknown)
10.33.72.227	f4:c8:8a:d6:d8:50	(Unknown)
10.33.72.233	48:68:4a:b3:70:0e	(Unknown)
10.33.72.113	fe:e5:08:bc:2a:9f	(Unknown: locally administered)
10.33.72.231	42:61:f6:99:da:d9	(Unknown: locally administered)
10.33.72.252	12:63:a1:3e:bb:06	(Unknown: locally administered)
10.33.72.254	c4:03:a8:65:0a:3b	(Unknown)
10.33.72.253	34:6f:24:c7:1b:4d	(Unknown)
10.33.72.242	ca:23:41:3b:82:49	(Unknown: locally administered)
10.33.73.0	    f4:c8:8a:e2:b6:bb	(Unknown)
10.33.72.255	f4:c8:8a:54:89:77	(Unknown)
10.33.72.236	32:b0:43:cc:8f:d2	(Unknown: locally administered)
10.33.73.2	    d4:d8:53:c6:a8:63	(Unknown)
10.33.71.77	    1e:71:ea:4f:59:6a	(Unknown: locally administered)
10.33.73.3	    10:68:38:3f:a6:e5	(Unknown)
10.33.72.234	fa:f7:f1:b8:dd:af	(Unknown: locally administered)
10.33.73.7	    48:e7:da:58:7c:03	(Unknown)
10.33.73.8	    84:94:37:d9:9f:fb	(Unknown)
10.33.73.9	    84:1b:77:fd:5c:a0	(Unknown)
10.33.73.17	    3c:21:9c:5a:5d:20	(Unknown)
10.33.73.18	    f4:6d:3f:65:8b:50	(Unknown)
10.33.73.5	    68:7a:64:84:db:9f	(Unknown)
10.33.73.22	    6c:7e:67:c4:1b:4d	(Unknown)
10.33.73.16	    2c:0d:a7:df:ca:73	(Unknown)
10.33.72.149	96:5b:fb:ca:0a:cb	(Unknown: locally administered)
10.33.73.27	    c4:3d:1a:c1:f6:97	(Unknown)
10.33.73.31	    40:1a:58:d9:7a:86	(Unknown)
10.33.73.12	    d4:3b:04:a7:5a:a8	(Unknown)
10.33.72.250	9a:ed:98:44:ee:a5	(Unknown: locally administered)
10.33.72.52	    b2:ce:58:ec:15:b2	(Unknown: locally administered)
10.33.73.46	    c8:89:f3:e7:69:9f	(Unknown)
10.33.72.222	f4:6d:3f:32:3f:5c	(Unknown)
10.33.73.34	    72:a4:a0:7a:0e:5b	(Unknown: locally administered)
10.33.73.45	    f4:c8:8a:6f:04:05	(Unknown)
10.33.73.50	    28:6b:35:f2:3e:24	(Unknown)
10.33.73.35	    30:03:c8:8f:62:71	(Unknown)
10.33.73.59	    98:59:7a:99:c1:9a	(Unknown)
10.33.73.28	    50:5a:65:ea:37:8b	(Unknown)
10.33.73.71	    40:1a:58:3b:37:ec	(Unknown)
10.33.73.73	    48:e7:da:a7:c7:5f	(Unknown)
10.33.73.76	    e0:0a:f6:b0:73:d5	(Unknown)
10.33.73.77	    98:8d:46:c4:fa:e5	(Unknown)
10.33.73.51	    de:81:de:15:16:8a	(Unknown: locally administered)
10.33.73.82	    40:1a:58:4b:44:84	(Unknown)
10.33.73.87	    e4:0d:36:06:76:60	(Unknown)
10.33.73.47	    d6:5b:3d:ff:62:7f	(Unknown: locally administered)
10.33.73.61	    76:ee:9d:6e:d9:2a	(Unknown: locally administered)
10.33.73.93	    98:59:7a:c9:37:2c	(Unknown)
10.33.73.96	    2c:0d:a7:ae:5a:15	(Unknown)
10.33.73.98	    38:7a:0e:c6:72:0d	(Unknown)
10.33.73.97	    bc:09:1b:1a:fd:bf	(Unknown)
10.33.73.100	b0:a4:60:cb:57:50	(Unknown)
10.33.73.101	20:2b:20:bf:13:eb	(Unknown)
10.33.73.81	    b0:dc:ef:bb:ff:9e	(Unknown)
10.33.73.95	    f4:c8:8a:72:7c:fc	(Unknown)
10.33.73.72	    30:89:4a:d2:5a:aa	(Unknown)
10.33.73.84	    8a:71:40:ae:93:f6	(Unknown: locally administered)
10.33.73.109	a4:f9:33:12:52:9b	(Unknown)
10.33.73.105	f8:b5:4d:ed:9d:3d	(Unknown)
10.33.73.112	f4:c8:8a:6f:09:dc	(Unknown)
10.33.73.110	20:2b:20:bf:43:33	(Unknown)
10.33.73.113	04:e8:b9:5c:4e:ff	(Unknown)
10.33.73.115	cc:5e:f8:6e:4b:33	(Unknown)
10.33.73.118	50:5a:65:4f:b8:61	(Unknown)
10.33.73.121	04:e8:b9:d6:07:86	(Unknown)
10.33.72.160	46:e4:46:0f:ef:10	(Unknown: locally administered)
10.33.73.120	70:d8:23:29:f9:78	(Unknown)
10.33.73.123	50:c2:e8:6c:33:23	(Unknown)
10.33.73.136	2a:c9:95:a7:52:b0	(Unknown: locally administered)
10.33.73.133	d2:ba:61:44:f4:2f	(Unknown: locally administered)
10.33.73.132	1c:57:dc:2f:e9:d8	(Unknown)
10.33.73.134	2c:3b:70:73:68:0b	(Unknown)
10.33.73.148	ba:8d:b1:77:b5:ba	(Unknown: locally administered)
10.33.73.107	98:59:7a:ca:5f:67	(Unknown)
10.33.73.129	32:a3:7f:18:55:e1	(Unknown: locally administered)
10.33.73.159	fe:92:cc:26:0e:b3	(Unknown: locally administered)
10.33.72.235	ce:c2:56:17:2c:62	(Unknown: locally administered)
10.33.73.168	f0:18:98:ac:75:be	(Unknown)
10.33.73.156	0a:76:3d:40:4d:84	(Unknown: locally administered)
10.33.73.67	    72:8c:8e:71:6c:79	(Unknown: locally administered)
10.33.73.119	30:89:4a:59:b2:c6	(Unknown)
10.33.73.153	76:10:9b:60:94:16	(Unknown: locally administered)
10.33.73.191	5e:d2:04:49:6c:79	(Unknown: locally administered)
10.33.72.190	56:10:47:f2:10:72	(Unknown: locally administered)
10.33.73.193	e4:0d:36:30:e9:ae	(Unknown)
10.33.73.195	9a:f0:c2:e5:3a:20	(Unknown: locally administered)
10.33.73.144	f8:ff:c2:24:b5:91	(Unknown)
10.33.73.199	30:89:4a:0f:4f:1a	(Unknown)
10.33.73.187	be:86:98:90:b4:c9	(Unknown: locally administered)
10.33.73.205	1c:57:dc:35:1c:6e	(Unknown)
10.33.73.185	5a:bf:f4:cf:1d:c8	(Unknown: locally administered)
10.33.73.194	76:ac:82:34:87:8e	(Unknown: locally administered)
10.33.73.209	1c:57:dc:59:00:ca	(Unknown)
10.33.73.226	c8:5e:a9:3e:3e:fb	(Unknown)
10.33.73.189	e6:30:e0:bc:03:6d	(Unknown: locally administered)
10.33.73.174	a4:cf:99:74:e2:42	(Unknown)
10.33.73.181	62:02:c7:72:0a:d5	(Unknown: locally administered)
10.33.73.192	e6:7d:2e:e6:2b:54	(Unknown: locally administered)
10.33.73.206	dc:46:28:cd:9a:6f	(Unknown)
10.33.73.201	66:8e:b3:3e:90:a4	(Unknown: locally administered)
10.33.73.150	86:72:b4:7e:f7:57	(Unknown: locally administered)
10.33.73.204	0e:78:75:d7:ca:fa	(Unknown: locally administered)
10.33.73.241	98:59:7a:b3:b7:c1	(Unknown)
10.33.73.164	c2:8d:8b:31:96:ba	(Unknown: locally administered)
10.33.73.242	3c:a6:f6:43:e8:a0	(Unknown)
10.33.73.247	50:5a:65:ab:b8:f7	(Unknown)
10.33.73.252	2a:a6:0b:22:50:dc	(Unknown: locally administered)
10.33.72.243	8a:2b:a9:ca:25:b0	(Unknown: locally administered)
10.33.73.170	76:df:ff:e2:16:29	(Unknown: locally administered)
10.33.73.208	00:91:9e:4b:aa:55	(Unknown)
10.33.73.218	8a:bb:06:b3:a9:23	(Unknown: locally administered)
10.33.73.238	2a:6a:7a:32:20:74	(Unknown: locally administered)
10.33.73.32	    6a:1a:0d:6b:73:27	(Unknown: locally administered)
10.33.73.216	0e:d4:65:4d:b4:3d	(Unknown: locally administered)
10.33.72.159	b6:09:24:d0:e2:d3	(Unknown: locally administered)
10.33.73.220	da:05:79:63:c5:a5	(Unknown: locally administered)
10.33.73.203	22:0f:d4:63:7c:69	(Unknown: locally administered)
10.33.74.36	    68:34:21:ea:e0:2f	(Unknown)
10.33.74.8	    d0:81:7a:bb:b6:04	(Unknown)
10.33.74.33	    58:96:71:9d:11:1e	(Unknown)
10.33.74.35	    d4:e9:8a:d0:b6:19	(Unknown)
10.33.73.244	f4:bf:80:c0:a1:d3	(Unknown)
10.33.73.253	b2:03:9d:bd:c5:88	(Unknown: locally administered)
10.33.72.205	be:5c:c6:88:7b:74	(Unknown: locally administered)
10.33.73.240	1a:93:f7:9a:ec:e5	(Unknown: locally administered)
10.33.73.157	b2:6a:62:2c:07:53	(Unknown: locally administered)
10.33.73.65	    be:8b:4a:37:4a:3f	(Unknown: locally administered)
10.33.74.31	    6e:ae:de:51:aa:1e	(Unknown: locally administered)
10.33.73.248	76:92:1a:b9:8c:77	(Unknown: locally administered)
10.33.74.93	    dc:46:28:b5:66:57	(Unknown)
10.33.74.73	    36:0b:1d:7c:95:e5	(Unknown: locally administered)
10.33.73.127	a4:9b:4f:0d:65:f1	(Unknown)
10.33.71.64	    9a:68:4e:1c:0d:ed	(Unknown: locally administered)
10.33.73.161	16:fc:7a:2d:d3:4e	(Unknown: locally administered)
10.33.73.130	a6:a5:ec:36:7d:56	(Unknown: locally administered)
10.33.74.115	b2:ee:f7:b5:85:94	(Unknown: locally administered)
10.33.74.135	82:11:3d:77:74:f4	(Unknown: locally administered)
10.33.73.178	7a:8c:0d:c5:cc:d0	(Unknown: locally administered)
10.33.74.121	22:e2:b5:0a:2f:50	(Unknown: locally administered)
10.33.74.158	98:bd:80:8b:c9:fa	(Unknown)
10.33.73.214	e2:a0:a6:b6:f0:50	(Unknown: locally administered)
10.33.74.172	e2:9d:74:34:d1:74	(Unknown: locally administered)
10.33.73.135	0e:cc:f6:a4:89:c2	(Unknown: locally administered)
10.33.74.134	12:09:42:c5:ff:3a	(Unknown: locally administered)
10.33.74.160	9c:58:84:17:f9:ed	(Unknown)
10.33.74.166	72:d8:27:4f:00:80	(Unknown: locally administered)
10.33.74.159	1c:ce:51:94:46:d2	(Unknown)
10.33.74.165	1c:ce:51:25:0e:d7	(Unknown)
10.33.74.220	a0:29:42:24:54:73	(Unknown)
10.33.74.150	0e:d9:97:61:22:1f	(Unknown: locally administered)
10.33.74.173	26:9d:fc:5c:0f:27	(Unknown: locally administered)
10.33.74.227	80:45:dd:6f:28:9f	(Unknown)
10.33.74.229	f8:fe:5e:18:12:df	(Unknown)
10.33.74.90	    de:7c:12:48:51:98	(Unknown: locally administered)
10.33.73.250	ae:7d:60:fa:c9:f7	(Unknown: locally administered)
10.33.73.219	f6:99:7b:56:f4:56	(Unknown: locally administered)
10.33.73.254	52:f7:f7:73:f7:8f	(Unknown: locally administered)
10.33.74.226	26:34:14:5f:36:16	(Unknown: locally administered)
10.33.75.19	    ea:83:6b:33:12:b6	(Unknown: locally administered)
10.33.74.131	76:e1:2b:10:37:9d	(Unknown: locally administered)
10.33.73.202	86:a4:8f:a0:56:92	(Unknown: locally administered)
10.33.75.18	    32:3b:02:33:91:9a	(Unknown: locally administered)
10.33.75.30	    66:d7:22:34:c9:bc	(Unknown: locally administered)
10.33.74.142	ba:e4:b3:ca:af:b0	(Unknown: locally administered)
10.33.73.140	ca:5e:25:3c:89:b2	(Unknown: locally administered)
10.33.75.3	    d6:bc:96:ea:e2:91	(Unknown: locally administered)
10.33.73.232	f2:20:79:dc:29:cb	(Unknown: locally administered)
10.33.75.16	    72:b8:22:c4:31:8e	(Unknown: locally administered)
10.33.75.32	    4e:f5:fc:13:91:87	(Unknown: locally administered)
10.33.73.177	f2:8f:65:58:27:9f	(Unknown: locally administered)
10.33.74.20	    6e:cb:44:2d:ab:15	(Unknown: locally administered)
10.33.75.87	    8c:c6:81:98:78:53	(Unknown)
10.33.73.167	52:f1:50:f2:88:55	(Unknown: locally administered)
10.33.73.188	b2:c1:5a:4d:ad:69	(Unknown: locally administered)
10.33.75.103	48:a4:72:dd:58:79	(Unknown)
10.33.75.92	    aa:2e:ea:a0:12:d6	(Unknown: locally administered)
10.33.75.101	2e:2a:28:18:1a:09	(Unknown: locally administered)
10.33.75.73	    8a:7c:a7:d8:a1:ca	(Unknown: locally administered)
10.33.74.228	cc:08:fa:8a:6c:f8	(Unknown)
10.33.75.60	    fa:d1:f2:b7:29:95	(Unknown: locally administered)
10.33.75.105	d6:b8:41:6f:ee:27	(Unknown: locally administered)
10.33.75.62	    ba:81:66:3f:71:2f	(Unknown: locally administered)
10.33.75.198	70:d8:23:50:2a:94	(Unknown)
10.33.75.191	1a:a7:50:8b:71:92	(Unknown: locally administered)
10.33.75.236	6c:7e:67:d5:36:24	(Unknown)
10.33.75.239	6e:6c:29:a0:61:96	(Unknown: locally administered)
10.33.76.9	    2a:e2:e3:87:fc:51	(Unknown: locally administered)
10.33.76.13	    e2:6a:ab:ab:03:27	(Unknown: locally administered)
10.33.75.4	    a4:cf:99:53:8f:f8	(Unknown)
10.33.76.71	    0a:2a:ef:f1:ba:41	(Unknown: locally administered)
10.33.73.139	16:9a:2c:bd:77:e9	(Unknown: locally administered)
10.33.76.88	    dc:46:28:bb:78:44	(Unknown)
10.33.76.97	    b2:6f:0b:bb:f5:0d	(Unknown: locally administered)
10.33.76.110	28:c5:d2:ea:30:53	(Unknown)
10.33.76.146	9e:dd:c3:f0:07:b6	(Unknown: locally administered)
10.33.76.111	a0:b3:39:64:96:ff	(Unknown)
10.33.76.105	aa:4b:2e:46:10:df	(Unknown: locally administered)
10.33.76.104	42:63:82:42:b7:41	(Unknown: locally administered)
10.33.76.151	be:86:a1:e1:e7:4d	(Unknown: locally administered)
10.33.76.165	62:09:2c:e6:5c:b6	(Unknown: locally administered)
10.33.74.151	22:88:96:2e:ba:83	(Unknown: locally administered)
10.33.76.176	3c:0a:f3:21:d9:ad	(Unknown)
10.33.76.113	94:bb:43:41:b3:c9	(Unknown)
10.33.76.184	20:1e:88:41:d2:aa	(Unknown)
10.33.75.110	fe:8e:97:d0:93:83	(Unknown: locally administered)
10.33.76.204	f0:9e:4a:6a:0a:95	(Unknown)
10.33.76.203	5c:e9:1e:69:0b:fd	(Unknown)
10.33.76.153	32:ac:cc:4a:97:60	(Unknown: locally administered)
10.33.76.191	5c:fb:3a:99:a9:bd	(Unknown)
10.33.76.152	3a:47:f8:6a:82:04	(Unknown: locally administered)
10.33.73.234	06:09:f0:e6:1a:ea	(Unknown: locally administered)
10.33.76.145	20:91:df:e0:d6:b6	(Unknown)
10.33.74.12	    ca:63:d0:88:d8:21	(Unknown: locally administered)
10.33.76.155	ce:e0:40:dc:31:a7	(Unknown: locally administered)
10.33.76.122	ae:90:13:67:60:50	(Unknown: locally administered)
10.33.77.14	    58:06:5d:e0:ca:2f	(Unknown)
10.33.77.26	    98:bd:80:d5:2b:bd	(Unknown)
10.33.77.30	    e4:60:17:40:55:6a	(Unknown)
10.33.77.44	    a0:80:69:b7:c9:7e	(Unknown)
10.33.77.47	    74:13:ea:8e:bb:06	(Unknown)
10.33.77.17	    60:3e:5f:38:9f:e4	(Unknown)
10.33.77.29	    58:cd:c9:22:43:fd	(Unknown)
10.33.77.24	    02:17:57:68:08:03	(Unknown: locally administered)
10.33.77.57	    42:d7:a3:91:70:e3	(Unknown: locally administered)
10.33.77.61	    84:c5:a6:76:62:b8	(Unknown)
10.33.76.205	de:a0:44:40:1d:b4	(Unknown: locally administered)
10.33.77.70	    5c:3a:45:af:ea:b7	(Unknown)
10.33.77.55	    62:e3:09:60:e9:52	(Unknown: locally administered)
10.33.77.50	    1a:82:2b:c2:7a:da	(Unknown: locally administered)
10.33.77.105	80:19:34:04:ba:b9	(Unknown)
10.33.77.69	    ca:58:e3:c6:0f:d4	(Unknown: locally administered)
10.33.77.82	    d8:80:83:d0:d6:eb	(Unknown)
10.33.77.107	4c:5f:70:9c:08:5b	(Unknown)
10.33.77.80	    42:7f:c1:8d:7c:aa	(Unknown: locally administered)
10.33.77.111	d0:65:78:4c:bf:08	(Unknown)
10.33.77.112	4e:a0:5d:d1:ce:6d	(Unknown: locally administered)
10.33.77.89	    82:b9:63:7d:08:55	(Unknown: locally administered)
10.33.77.125	20:0d:b0:cc:68:bb	(Unknown)
10.33.77.71	    84:94:37:d8:e7:81	(Unknown)
10.33.77.147	fc:b3:bc:c7:28:6a	(Unknown)
10.33.77.148	e4:c7:67:81:d0:3f	(Unknown)
10.33.77.103	76:9e:4a:bf:86:bc	(Unknown: locally administered)
10.33.77.127	a8:41:f4:63:b2:c6	(Unknown)
10.33.77.128	f8:5e:a0:1e:d3:f9	(Unknown)
10.33.77.130	f6:98:5d:3e:e4:04	(Unknown: locally administered)
10.33.77.143	9c:58:84:18:9c:ce	(Unknown)
10.33.77.153	1c:ce:51:24:c7:33	(Unknown)
10.33.77.157	14:5a:fc:7f:13:93	(Unknown)
10.33.77.156	d4:3b:04:ff:44:7a	(Unknown)
10.33.77.159	f8:54:f6:ba:c5:1a	(Unknown)
10.33.77.27	    4e:92:53:30:b1:13	(Unknown: locally administered)
10.33.77.152	d4:d8:53:78:45:b2	(Unknown)
10.33.77.164	d4:e9:8a:61:17:a0	(Unknown)
10.33.77.165	34:c9:3d:22:97:2d	(Unknown)
10.33.77.139	60:3e:5f:4a:04:47	(Unknown)
10.33.77.167	04:33:c2:f4:61:81	(Unknown)
10.33.77.170	10:63:c8:68:8c:21	(Unknown)
10.33.77.92	    06:50:df:37:6b:25	(Unknown: locally administered)
10.33.77.173	10:68:38:8e:2e:ef	(Unknown)
10.33.77.140	14:7f:ce:93:64:44	(Unknown)
10.33.77.135	26:b5:2f:f9:9a:12	(Unknown: locally administered)
10.33.76.159	b2:48:0f:74:bd:22	(Unknown: locally administered)
10.33.77.166	e8:c8:29:cb:a5:8e	(Unknown)
10.33.77.199	c0:35:32:1c:af:a9	(Unknown)
10.33.77.160	c8:94:02:f8:ab:97	(Unknown)
10.33.77.200	08:f8:bc:62:0f:37	(Unknown)
10.33.77.150	26:86:e4:6e:13:69	(Unknown: locally administered)
10.33.77.208	50:5a:65:50:4a:c9	(Unknown)
10.33.77.123	72:ac:9d:d6:a8:85	(Unknown: locally administered)
10.33.77.219	80:a9:97:1d:7b:22	(Unknown)
10.33.77.90	    1e:be:dd:c8:fb:4a	(Unknown: locally administered)
10.33.77.206	b8:1e:a4:6c:56:97	(Unknown)
10.33.77.201	5a:c6:62:f2:d4:c9	(Unknown: locally administered)
10.33.77.229	18:93:41:bc:5f:de	(Unknown)
10.33.77.232	94:bb:43:eb:7a:d3	(Unknown)
10.33.77.236	6c:2f:80:b5:1b:e8	(Unknown)
10.33.77.237	08:8e:90:f6:6c:b0	(Unknown)
10.33.77.209	f2:b3:44:24:5d:9f	(Unknown: locally administered)
10.33.77.205	9c:58:84:17:32:e6	(Unknown)
10.33.77.196	18:cc:18:fb:ad:d3	(Unknown)
10.33.77.203	26:52:67:4a:f5:25	(Unknown: locally administered)
10.33.77.230	18:93:41:86:fe:16	(Unknown)
10.33.77.221	cc:b0:da:ac:9b:db	(Unknown)
10.33.76.231	cc:08:fa:8b:2d:88	(Unknown)
10.33.73.58	    f2:43:93:aa:49:d3	(Unknown: locally administered)
10.33.76.154	be:14:d4:b6:bb:78	(Unknown: locally administered)
10.33.78.67	    9c:b6:d0:dc:5f:1b	(Unknown)
10.33.76.219	cc:08:fa:7b:7a:03	(Unknown)
10.33.77.217	4e:07:b3:80:06:ee	(Unknown: locally administered)
10.33.78.62	    f2:85:15:6c:45:8c	(Unknown: locally administered)
10.33.78.105	18:56:80:fb:66:ac	(Unknown)
10.33.77.228	2c:3b:70:b0:9a:5b	(Unknown)
10.33.78.139	90:09:df:a4:67:21	(Unknown)
10.33.78.142	28:16:ad:e0:cf:81	(Unknown)
10.33.78.143	70:a8:d3:78:be:be	(Unknown)
10.33.78.104	e0:dc:ff:df:1f:37	(Unknown)
10.33.78.151	80:65:7c:d6:8a:a3	(Unknown)
10.33.78.130	3a:14:36:51:6e:2d	(Unknown: locally administered)
10.33.78.155	28:c5:d2:67:28:89	(Unknown)
10.33.78.119	72:e6:eb:37:12:c5	(Unknown: locally administered)
10.33.78.159	30:f6:ef:e6:ad:98	(Unknown)
10.33.78.137	64:a2:00:5c:f9:7a	(Unknown)
10.33.78.88	    b2:9e:52:49:d5:e1	(Unknown: locally administered)
10.33.78.163	1a:8e:b5:98:77:38	(Unknown: locally administered)
10.33.78.166	d0:65:78:37:d6:29	(Unknown)
10.33.78.121	ea:5e:c5:68:e5:31	(Unknown: locally administered)
10.33.77.67	    06:6c:b1:fb:fa:f8	(Unknown: locally administered)
10.33.78.208	bc:03:58:b5:3e:c5	(Unknown)
10.33.78.168	60:3e:5f:5a:b2:43	(Unknown)
10.33.72.155	7e:c0:0a:ac:0c:c8	(Unknown: locally administered)
10.33.78.157	e6:9f:d1:5d:bb:a6	(Unknown: locally administered)
10.33.78.174	ca:00:68:9a:3c:0a	(Unknown: locally administered)
10.33.78.165	c0:35:32:e6:90:05	(Unknown)
10.33.78.160	14:7d:da:bf:e0:d6	(Unknown)
10.33.78.153	b2:d9:6c:00:48:67	(Unknown: locally administered)
10.33.78.171	a4:83:e7:75:7c:78	(Unknown)
10.33.77.226	36:db:da:f8:ee:b9	(Unknown: locally administered)
10.33.78.147	94:bb:43:d9:e1:25	(Unknown)
10.33.78.230	50:5a:65:4e:04:cb	(Unknown)
10.33.78.236	10:91:d1:24:98:e8	(Unknown)
10.33.78.235	9c:fc:e8:79:f3:ba	(Unknown)
10.33.78.127	82:1a:84:a6:e1:ae	(Unknown: locally administered)
10.33.78.240	20:0b:74:37:40:d5	(Unknown)
10.33.78.120	b6:63:17:a1:93:3d	(Unknown: locally administered)
10.33.78.250	a8:41:f4:f1:62:4c	(Unknown)
10.33.78.252	e4:0d:36:2f:88:9d	(Unknown)
10.33.78.136	46:f9:d5:3d:8a:46	(Unknown: locally administered)
10.33.78.233	f8:fe:5e:a5:67:93	(Unknown)
10.33.78.247	36:1b:3b:a0:6b:40	(Unknown: locally administered)
10.33.78.173	5e:9e:b6:64:c4:52	(Unknown: locally administered)
10.33.79.8	    c2:1e:93:71:01:bf	(Unknown: locally administered)
10.33.79.10	    a8:6d:aa:e7:87:40	(Unknown)
10.33.79.1	    a8:41:f4:ea:29:b5	(Unknown)
10.33.79.17	    4c:5f:70:5f:67:89	(Unknown)
10.33.79.14	    d4:d8:53:78:45:b0	(Unknown)
10.33.78.254	1a:d3:b6:8c:7e:c0	(Unknown: locally administered)
10.33.79.2	    9e:1f:be:9e:e2:74	(Unknown: locally administered)
10.33.79.0	    74:97:79:66:39:b3	(Unknown)
10.33.78.234	34:6f:24:e2:da:27	(Unknown)
10.33.78.246	62:7e:0b:fb:eb:bd	(Unknown: locally administered)
10.33.77.155	32:ae:62:5d:d3:f4	(Unknown: locally administered)
10.33.78.56	    02:cb:d7:f3:d7:73	(Unknown: locally administered)
10.33.78.249	2c:98:11:56:bf:f1	(Unknown)
10.33.75.235	86:c4:82:b5:e2:5a	(Unknown: locally administered)
10.33.79.5	    12:8d:a4:42:1b:41	(Unknown: locally administered)
10.33.79.7	    2a:7a:a1:70:dd:b6	(Unknown: locally administered)
10.33.78.123	ba:44:ec:c8:23:58	(Unknown: locally administered)
10.33.78.190	ce:38:75:32:40:75	(Unknown: locally administered)
10.33.78.138	56:4f:90:e9:ce:5b	(Unknown: locally administered)
10.33.77.233	e2:c9:d0:c0:3a:28	(Unknown: locally administered)
10.33.79.85	    f0:b6:1e:0a:d0:34	(Unknown)
10.33.78.81	    da:b0:df:bf:0e:9f	(Unknown: locally administered)
10.33.77.207	a6:b9:e3:40:1c:31	(Unknown: locally administered)
10.33.76.57	    8e:83:32:fd:dd:4b	(Unknown: locally administered)
10.33.79.12	    a6:37:d2:09:07:27	(Unknown: locally administered)
10.33.78.238	1a:cf:2f:b3:d7:d3	(Unknown: locally administered)
10.33.77.204	5e:e2:5e:14:71:22	(Unknown: locally administered)
10.33.78.117	68:ca:c4:99:4c:7b	(Unknown)
10.33.79.15	    8e:90:02:04:93:6b	(Unknown: locally administered)
10.33.79.16	    e2:08:a4:34:a2:ef	(Unknown: locally administered)
10.33.77.168	3e:4d:a2:6d:37:1d	(Unknown: locally administered)
10.33.79.155	28:6b:35:f0:78:a0	(Unknown)
10.33.79.160	88:e9:fe:88:15:52	(Unknown)
10.33.76.50	    f6:49:7b:c8:02:01	(Unknown: locally administered)
10.33.78.129	26:52:91:2b:f9:43	(Unknown: locally administered)
10.33.77.211	66:41:bc:60:38:6c	(Unknown: locally administered)
10.33.77.12	    de:cf:50:1e:e4:b2	(Unknown: locally administered)
10.33.79.115	72:90:60:02:33:b5	(Unknown: locally administered)
10.33.79.254	7c:5a:1c:d3:d8:76	(Unknown)
10.33.79.232	a0:02:a5:be:26:4d	(Unknown)
10.33.79.236	d8:80:83:d0:03:05	(Unknown)
10.33.79.147	2e:b9:b1:25:2d:0b	(Unknown: locally administered)
10.33.79.212	80:a9:97:1a:f5:ef	(Unknown)
10.33.79.93	    ee:77:aa:5c:4a:ed	(Unknown: locally administered)
10.33.79.96	    92:65:73:3c:bc:75	(Unknown: locally administered)
10.33.79.195	ea:7e:d5:64:b1:37	(Unknown: locally administered)
10.33.78.108	80:a9:97:20:7f:d0	(Unknown)
10.33.79.233	92:7d:ec:a1:98:93	(Unknown: locally administered)
10.33.65.210	2c:33:58:72:52:ae	(Unknown) (DUP: 2)
10.33.68.25	    ac:74:b1:56:6d:ff	(Unknown) (DUP: 2)
10.33.68.15	    a0:59:50:ea:9e:7b	(Unknown) (DUP: 2)
10.33.78.150	7c:21:4a:e8:11:1a	(Unknown) (DUP: 2)
10.33.72.230	8c:17:59:dc:f8:f2	(Unknown) (DUP: 2)
10.33.72.192	44:e5:17:07:1b:24	(Unknown) (DUP: 2)
10.33.73.131	f2:29:a3:69:e3:4b	(Unknown: locally administered)
10.33.74.167	be:be:52:62:83:b7	(Unknown: locally administered)

618 packets received by filter, 0 packets dropped by kernel
Ending arp-scan 1.10.0: 4096 hosts scanned in 16.028 seconds (255.55 hosts/sec). 611 responded
```
- Suite à ce scan , nous relevons des IP avec des adresse mac administrés localement qui ont une configuration manuelle ou spécifique ne suivant pas le schéma habituel des adresses MAC attribuées par les fabricants. IL y'a des adresses IP avec des adresses mac non identifiés, surement les appareils téléphoniques des étudiants et ou des ordinateurs et autres appareils qui sont inhabituels sur le réseau. Et pour finir, je relève des duplicata (DUP) sur certains appareils qui peuvent signifier qu'il y'a plusieurs interfaces réseaux ou bien que ces appareils soient actifs sur plusieurs sous-réseaux.


🌞 Équipements réseau 

-Je vois une télévision du batiment affichant une IP donc je vais la scanner:
```
batman33@BATPC:~$ sudo nmap -sS 10.33.81.227
[sudo] Mot de passe de batman33 : 
Starting Nmap 7.93 ( https://nmap.org ) at 2024-10-10 16:08 CEST
Nmap scan report for 10.33.81.227
Host is up (0.0024s latency).
Not shown: 996 closed tcp ports (reset)
PORT     STATE SERVICE
1080/tcp open  socks
1443/tcp open  ies-lm
8000/tcp open  http-alt
8600/tcp open  asterix

Nmap done: 1 IP address (1 host up) scanned in 0.32 seconds
```

- En regardant le résultat, on voit que tous les ports sont ouverts. Par curiosité, je vais prendre le port 8000 (10.33.81.227:8000) et le regarder sur le navigateur web sur quoi je vais tomber sur le site de eshare.app permettant de caster son écran de téléphone ou de son ordinateur à la télévision , qui est héberger localement sur la télévision en http. Pareil pour le 10.33.81.227:1443 ou le message "Client sent an HTTP request to an HTTPS server." résultant d'une mauvaise configuration.

-Ensuite , je vais scanner le réseau secondaire afin de trouver toutes les adresses ip de chaque télévision allumés :
```
batman33@BATPC:~$ sudo nmap -sS -n 10.33.81.227/25 -p1443 --open
Starting Nmap 7.93 ( https://nmap.org ) at 2024-10-10 16:12 CEST
Nmap scan report for 10.33.81.132
Host is up (0.0043s latency).

PORT     STATE SERVICE
1443/tcp open  ies-lm

Nmap scan report for 10.33.81.194
Host is up (0.0024s latency).

PORT     STATE SERVICE
1443/tcp open  ies-lm

Nmap scan report for 10.33.81.195
Host is up (0.0022s latency).

PORT     STATE SERVICE
1443/tcp open  ies-lm

Nmap scan report for 10.33.81.196
Host is up (0.0026s latency).

PORT     STATE SERVICE
1443/tcp open  ies-lm

Nmap scan report for 10.33.81.198
Host is up (0.0025s latency).

PORT     STATE SERVICE
1443/tcp open  ies-lm

Nmap scan report for 10.33.81.204
Host is up (0.0023s latency).

PORT     STATE SERVICE
1443/tcp open  ies-lm

Nmap scan report for 10.33.81.205
Host is up (0.0022s latency).

PORT     STATE SERVICE
1443/tcp open  ies-lm

Nmap scan report for 10.33.81.219
Host is up (0.0058s latency).

PORT     STATE SERVICE
1443/tcp open  ies-lm

Nmap scan report for 10.33.81.226
Host is up (0.0027s latency).

PORT     STATE SERVICE
1443/tcp open  ies-lm

Nmap scan report for 10.33.81.227
Host is up (0.0027s latency).

PORT     STATE SERVICE
1443/tcp open  ies-lm

Nmap scan report for 10.33.81.236
Host is up (0.0024s latency).

PORT     STATE SERVICE
1443/tcp open  ies-lm

Nmap scan report for 10.33.81.237
Host is up (0.0024s latency).

PORT     STATE SERVICE
1443/tcp open  ies-lm

Nmap scan report for 10.33.81.238
Host is up (0.0024s latency).

PORT     STATE SERVICE
1443/tcp open  ies-lm

Nmap scan report for 10.33.81.239
Host is up (0.0035s latency).

PORT     STATE SERVICE
1443/tcp open  ies-lm

Nmap scan report for 10.33.81.245
Host is up (0.0032s latency).

PORT     STATE SERVICE
1443/tcp open  ies-lm

Nmap scan report for 10.33.81.246
Host is up (0.0026s latency).

PORT     STATE SERVICE
1443/tcp open  ies-lm

Nmap scan report for 10.33.81.247
Host is up (0.0025s latency).

PORT     STATE SERVICE
1443/tcp open  ies-lm

Nmap scan report for 10.33.81.248
Host is up (0.0025s latency).

PORT     STATE SERVICE
1443/tcp open  ies-lm

Nmap done: 128 IP addresses (19 hosts up) scanned in 2.42 seconds

batman33@BATPC:~$ sudo nmap -sS -n 10.33.81.227/25 -p1443 --open
[sudo] Mot de passe de batman33 : 
Starting Nmap 7.93 ( https://nmap.org ) at 2024-10-11 16:31 CEST
Nmap scan report for 10.33.81.132
Host is up (0.0023s latency).

PORT     STATE SERVICE
1443/tcp open  ies-lm

Nmap scan report for 10.33.81.204
Host is up (0.0074s latency).

PORT     STATE SERVICE
1443/tcp open  ies-lm

Nmap scan report for 10.33.81.205
Host is up (0.0067s latency).

PORT     STATE SERVICE
1443/tcp open  ies-lm

Nmap scan report for 10.33.81.219
Host is up (0.0043s latency).

PORT     STATE SERVICE
1443/tcp open  ies-lm

Nmap scan report for 10.33.81.221
Host is up (0.0028s latency).

PORT     STATE SERVICE
1443/tcp open  ies-lm

Nmap scan report for 10.33.81.225
Host is up (0.0052s latency).

PORT     STATE SERVICE
1443/tcp open  ies-lm

Nmap scan report for 10.33.81.226
Host is up (0.0027s latency).

PORT     STATE SERVICE
1443/tcp open  ies-lm

Nmap scan report for 10.33.81.227
Host is up (0.0027s latency).

PORT     STATE SERVICE
1443/tcp open  ies-lm

Nmap scan report for 10.33.81.236
Host is up (0.0026s latency).

PORT     STATE SERVICE
1443/tcp open  ies-lm

Nmap scan report for 10.33.81.238
Host is up (0.0026s latency).

PORT     STATE SERVICE
1443/tcp open  ies-lm

Nmap scan report for 10.33.81.239
Host is up (0.0030s latency).

PORT     STATE SERVICE
1443/tcp open  ies-lm

Nmap scan report for 10.33.81.247
Host is up (0.0022s latency).

PORT     STATE SERVICE
1443/tcp open  ies-lm

Nmap scan report for 10.33.81.248
Host is up (0.0022s latency).

PORT     STATE SERVICE
1443/tcp open  ies-lm

Nmap done: 128 IP addresses (14 hosts up) scanned in 2.58 seconds
```

- Et voilà les résultats obtenus. À savoir que cette opération a été effectué 2/3 fois par mesure de vérification. En effet , avec le professionnel qui a superviser ce travail, nous nous étions rendus compte que suite à une manipulation sur la télévision de notre salle, cela a impacté toutes les télévisions allumer donc tous les professeurs faisant cours dans les autres salles de classes mais qui n'utilisaient pas la télévisions se sont vu voir le contenu de l'ordinateur de notre salle de notre télévision. Au départ, j'ai trouvé 19 télévision, mais cette fois j'en ai trouvé 14, je conclue donc que la différence s'explique par le fait que 5 télévisions ont été tout simplement éteintes.

🌞 Détection d'OS sur quelques machines du réseau

```
batman33@BATPC:~$ sudo nmap -O 10.33.81.227
[sudo] Mot de passe de batman33 : 
Starting Nmap 7.93 ( https://nmap.org ) at 2024-10-14 08:25 CEST
Nmap scan report for 10.33.81.227
Host is up (0.0050s latency).
Not shown: 996 closed tcp ports (reset)
PORT     STATE SERVICE
1080/tcp open  socks
1443/tcp open  ies-lm
8000/tcp open  http-alt
8600/tcp open  asterix
No exact OS matches for host (If you know what OS is running on it, see https://nmap.org/submit/ ).
TCP/IP fingerprint:
OS:SCAN(V=7.93%E=4%D=10/14%OT=1080%CT=1%CU=40432%PV=Y%DS=2%DC=I%G=Y%TM=670C
OS:B95D%P=x86_64-pc-linux-gnu)SEQ(SP=105%GCD=1%ISR=10B%TI=Z%II=I%TS=A)OPS(O
OS:1=M5B4ST11NW6%O2=M5B4ST11NW6%O3=M5B4NNT11NW6%O4=M5B4ST11NW6%O5=M5B4ST11N
OS:W6%O6=M5B4ST11)WIN(W1=FFFF%W2=FFFF%W3=FFFF%W4=FFFF%W5=FFFF%W6=FFFF)ECN(R
OS:=N)T1(R=Y%DF=Y%T=40%S=O%A=S+%F=AS%RD=0%Q=)T2(R=N)T3(R=N)T4(R=N)T5(R=Y%DF
OS:=Y%T=40%W=0%S=Z%A=S+%F=AR%O=%RD=0%Q=)T6(R=N)T7(R=N)U1(R=Y%DF=N%T=40%IPL=
OS:164%UN=0%RIPL=G%RID=G%RIPCK=G%RUCK=G%RUD=G)IE(R=Y%DFI=N%T=40%CD=S)
 
Network Distance: 2 hops

OS detection performed. Please report any incorrect results at https://nmap.org/submit/ .
Nmap done: 1 IP address (1 host up) scanned in 12.77 seconds

batman33@BATPC:~$ sudo nmap -O 10.33.66.94
Starting Nmap 7.93 ( https://nmap.org ) at 2024-10-14 08:25 CEST
Nmap scan report for 10.33.66.94
Host is up (0.000084s latency).
Not shown: 998 closed tcp ports (reset)
PORT    STATE SERVICE
22/tcp  open  ssh
902/tcp open  iss-realsecure
Device type: general purpose
Running: Linux 2.6.X
OS CPE: cpe:/o:linux:linux_kernel:2.6.32
OS details: Linux 2.6.32
Network Distance: 0 hops

OS detection performed. Please report any incorrect results at https://nmap.org/submit/ .
Nmap done: 1 IP address (1 host up) scanned in 1.64 seconds

batman33@BATPC:~$ sudo nmap -O 10.33.73.73
Starting Nmap 7.93 ( https://nmap.org ) at 2024-10-14 10:11 CEST
Nmap scan report for 10.33.73.73
Host is up (0.0091s latency).
Not shown: 999 filtered tcp ports (no-response)
PORT     STATE SERVICE
3306/tcp open  mysql
MAC Address: 48:E7:DA:A7:C7:5F (AzureWave Technology)
Warning: OSScan results may be unreliable because we could not find at least 1 open and 1 closed port
Aggressive OS guesses: Microsoft Windows 10 (95%), Microsoft Windows Server 2008 SP1 (90%), Microsoft Windows 10 1703 (89%), Microsoft Windows 10 1511 - 1607 (88%), Microsoft Windows Phone 7.5 or 8.0 (88%), Microsoft Windows 10 1607 (87%), Microsoft Windows 10 1511 (87%), Microsoft Windows Server 2008 R2 or Windows 8.1 (87%), Microsoft Windows Server 2016 (87%), Microsoft Windows 7 Professional or Windows 8 (87%)
No exact OS matches for host (test conditions non-ideal).
Network Distance: 1 hop

OS detection performed. Please report any incorrect results at https://nmap.org/submit/ .
Nmap done: 1 IP address (1 host up) scanned in 8.52 seconds
```


- Dans un premier temps, j'ai repris l'IP de la télévision ayant l'adresse 10.33.81.227. J'ai donc voulu scanner cette télévision afin de trouver quel OS est dans cette télévision. À la suite du premier résultat , je remarque que Nmap n'a pas trouvé exactement son OS car elle l'OS de cette télévision n'a pas de correspondance claire dans sa base de donnée connue. Je pourrai raffiner le scan avec l'option "-A" pour obtenir plus d'informations mais je m'arrete là. 

- Quant au deuxième scan , je l'ai effectué sur mon propre pc. Nmap me confirme bien que mon ordinateur tourne sous linux.

- Puis concernant le trosième scan, effectué sur pc d'un membre de ma classe. Bien que les résultats me montre plusieurs versions de windows avec des scores de fiabilité différentes , l'ordinateur tourne bien sous Windows 10.

🌞 Le bluetooth

- J'ai voulu aller encore plus loin en voulant faire un scan bluetooth au sein du batiment. Pour cela, j'ai utilisé l'outil bluetoothctl afin de mener à bien cette démarche.
```
bluetoothctl scan on
```

- Je joins à ce rapport en fichier annexe , le fichier "resultats_bluetooth.txt" pour donner de la matière à la recherche et aux résultats rendues. Là je vais faire un résumer de tous les appareils que j'ai trouvé ou nom avec leur quantité. Avec leurs adresses MAC, on pouvait soit utiliser le site macVendors pour reconnaitre quel type d'appareil cela était lié ou exécuter un script évitant de taper manuellement chaque adresse mac et gagner de ce fait du temps. À savoir que le scan a duré que quelques dizaines de secondes et non 5 minutes , afin d'éviter plusieurs doublons et autres soucis de gestion parce qu'en lançant le scan nous avons 3 informations importante. il y'a [NEW] correspondants aux nouveaux appareils connectés au bluetooth, [DEL] corresponds aux appareils ayant enlevé le bluetooth, et le [CHG] signifiant un changement de connectivité ou d'état.
```
- Intel Corporate

Cela semble etre un ordinateur fixe ayant allumé le bluetooth.

- Cypress Semiconductor x19

Ce sont des composants électroniques, au vu du nombre , cela semble etre potentiellement utilisé auprès des capteurs ou des télévisions de l'école.

- Salto SYSTEMS S.L x58

58 serrures électroniques relevés (pour badger afin de rentrer ou sortir de l'école chez les etudiants et personnels intégrés dans leurs téléphones). 

- Liteon TECHNOLOGY Corporation x11

Équipements électroniques inconnus.

- ASIMMPHONY TURKEY

Surement un type d'appareil de communication.

- Anite telecoms

Équipement pour les réseaux de communication

- Hewlett Packard Enterprise x17

Servers, équipements de réseaux, de stockage..

Invoxia

Dispositif de communication et de sécurité , surement une caméra de surveillance.

Not found x85

Il y'a 85 appareils dont l'adresse mac n'est pas identifiable. 
```

🌞 Les caméras

- Ma démarche cette fois-ci sera d'essayer de repérer toutes les caméras repérables dans le batiment. Après des recherches, pour rendre plus efficace mon scan , je vais préciser les ports 80c(protocole HTTP pour le trafic web non sécurisé),554 (protocole RTSP pour Real-Time Streaming Protocol utilisé pour le streaming vidéo en temps réel), 8080(protocole alternatif HTTP utilisé pour les servers) et 9000 (utilisé pour les médias).
```
batman33@BATPC:~$ sudo nmap -sS -O -p 80,554,9000 10.33.78.0/24
[sudo] Mot de passe de batman33 : 
Starting Nmap 7.93 ( https://nmap.org ) at 2024-10-14 11:31 CEST
Nmap scan report for 10.33.78.55
Host is up (0.34s latency).

PORT     STATE  SERVICE
80/tcp   closed http
554/tcp  closed rtsp
9000/tcp closed cslistener
MAC Address: C6:7D:89:02:84:98 (Unknown)
Too many fingerprints match this host to give specific OS details
Network Distance: 1 hop

Nmap scan report for 10.33.78.56
Host is up (0.56s latency).

PORT     STATE    SERVICE
80/tcp   filtered http
554/tcp  filtered rtsp
9000/tcp filtered cslistener
MAC Address: 02:CB:D7:F3:D7:73 (Unknown)
Too many fingerprints match this host to give specific OS details
Network Distance: 1 hop

Nmap scan report for 10.33.78.62
Host is up (0.66s latency).

PORT     STATE    SERVICE
80/tcp   filtered http
554/tcp  filtered rtsp
9000/tcp filtered cslistener
MAC Address: F2:85:15:6C:45:8C (Unknown)
Too many fingerprints match this host to give specific OS details
Network Distance: 1 hop

Nmap scan report for 10.33.78.67
Host is up (0.0084s latency).

PORT     STATE    SERVICE
80/tcp   open     http
554/tcp  filtered rtsp
9000/tcp filtered cslistener
MAC Address: 9C:B6:D0:DC:5F:1B (Rivet Networks)
Warning: OSScan results may be unreliable because we could not find at least 1 open and 1 closed port
Device type: general purpose|specialized
Running (JUST GUESSING): Microsoft Windows XP (91%), AVtech embedded (87%), FreeBSD 6.X|10.X (86%)
OS CPE: cpe:/o:microsoft:windows_xp::sp3 cpe:/o:freebsd:freebsd:6.2 cpe:/o:freebsd:freebsd:10.3
Aggressive OS guesses: Microsoft Windows XP SP3 (91%), AVtech Room Alert 26W environmental monitor (87%), Microsoft Windows XP SP2 (87%), FreeBSD 6.2-RELEASE (86%), FreeBSD 10.3-STABLE (85%)
No exact OS matches for host (test conditions non-ideal).
Network Distance: 1 hop

Nmap scan report for 10.33.78.81
Host is up (0.050s latency).

PORT     STATE  SERVICE
80/tcp   closed http
554/tcp  closed rtsp
9000/tcp closed cslistener
MAC Address: DA:B0:DF:BF:0E:9F (Unknown)
Too many fingerprints match this host to give specific OS details
Network Distance: 1 hop

Nmap scan report for 10.33.78.96
Host is up (0.71s latency).

PORT     STATE    SERVICE
80/tcp   filtered http
554/tcp  filtered rtsp
9000/tcp filtered cslistener
MAC Address: 10:BD:3A:61:4D:B6 (Unknown)
Device type: switch|VoIP adapter|VoIP phone
Running: 3Com embedded, Allied Telesyn embedded, D-Link embedded, Dell embedded, Grandstream embedded
OS CPE: cpe:/h:3com:3924 cpe:/h:alliedtelesyn:at-gs950 cpe:/h:dlink:des-3226l cpe:/h:dlink:dsl-2750u cpe:/h:dlink:dvg-4022s cpe:/h:dell:powerconnect_2708 cpe:/h:grandstream:gxp2000
Too many fingerprints match this host to give specific OS details
Network Distance: 1 hop

Nmap scan report for 10.33.78.104
Host is up (0.036s latency).

PORT     STATE  SERVICE
80/tcp   closed http
554/tcp  closed rtsp
9000/tcp closed cslistener
MAC Address: E0:DC:FF:DF:1F:37 (Xiaomi Communications)
Too many fingerprints match this host to give specific OS details
Network Distance: 1 hop

Nmap scan report for 10.33.78.105
Host is up (0.0061s latency).

PORT     STATE    SERVICE
80/tcp   filtered http
554/tcp  filtered rtsp
9000/tcp filtered cslistener
MAC Address: 18:56:80:FB:66:AC (Intel Corporate)
Too many fingerprints match this host to give specific OS details
Network Distance: 1 hop

Nmap scan report for 10.33.78.108
Host is up (0.96s latency).

PORT     STATE    SERVICE
80/tcp   filtered http
554/tcp  filtered rtsp
9000/tcp filtered cslistener
MAC Address: 80:A9:97:20:7F:D0 (Unknown)
Device type: switch|VoIP adapter|VoIP phone
Running: 3Com embedded, Allied Telesyn embedded, D-Link embedded, Dell embedded, Grandstream embedded
OS CPE: cpe:/h:3com:3924 cpe:/h:alliedtelesyn:at-gs950 cpe:/h:dlink:des-3226l cpe:/h:dlink:dsl-2750u cpe:/h:dlink:dvg-4022s cpe:/h:dell:powerconnect_2708 cpe:/h:grandstream:gxp2000
Too many fingerprints match this host to give specific OS details
Network Distance: 1 hop

Nmap scan report for 10.33.78.117
Host is up (0.44s latency).

PORT     STATE    SERVICE
80/tcp   filtered http
554/tcp  filtered rtsp
9000/tcp filtered cslistener
MAC Address: 68:CA:C4:99:4C:7B (Unknown)
Device type: switch|VoIP adapter|VoIP phone
Running: 3Com embedded, Allied Telesyn embedded, D-Link embedded, Dell embedded, Grandstream embedded
OS CPE: cpe:/h:3com:3924 cpe:/h:alliedtelesyn:at-gs950 cpe:/h:dlink:des-3226l cpe:/h:dlink:dsl-2750u cpe:/h:dlink:dvg-4022s cpe:/h:dell:powerconnect_2708 cpe:/h:grandstream:gxp2000
Too many fingerprints match this host to give specific OS details
Network Distance: 1 hop

Nmap scan report for 10.33.78.119
Host is up (0.052s latency).

PORT     STATE  SERVICE
80/tcp   closed http
554/tcp  closed rtsp
9000/tcp closed cslistener
MAC Address: 72:E6:EB:37:12:C5 (Unknown)
Too many fingerprints match this host to give specific OS details
Network Distance: 1 hop

Nmap scan report for 10.33.78.120
Host is up (0.95s latency).

PORT     STATE    SERVICE
80/tcp   filtered http
554/tcp  filtered rtsp
9000/tcp filtered cslistener
MAC Address: B6:63:17:A1:93:3D (Unknown)
Too many fingerprints match this host to give specific OS details
Network Distance: 1 hop

Nmap scan report for 10.33.78.121
Host is up (0.047s latency).

PORT     STATE  SERVICE
80/tcp   closed http
554/tcp  closed rtsp
9000/tcp closed cslistener
MAC Address: EA:5E:C5:68:E5:31 (Unknown)
Too many fingerprints match this host to give specific OS details
Network Distance: 1 hop

Nmap scan report for 10.33.78.123
Host is up (0.083s latency).

PORT     STATE  SERVICE
80/tcp   closed http
554/tcp  closed rtsp
9000/tcp closed cslistener
MAC Address: BA:44:EC:C8:23:58 (Unknown)
Too many fingerprints match this host to give specific OS details
Network Distance: 1 hop

Nmap scan report for 10.33.78.125
Host is up (0.0045s latency).

PORT     STATE  SERVICE
80/tcp   closed http
554/tcp  closed rtsp
9000/tcp closed cslistener
MAC Address: 98:5F:41:1D:62:58 (Unknown)
Too many fingerprints match this host to give specific OS details
Network Distance: 1 hop

Nmap scan report for 10.33.78.127
Host is up (0.70s latency).

PORT     STATE    SERVICE
80/tcp   filtered http
554/tcp  filtered rtsp
9000/tcp filtered cslistener
MAC Address: 82:1A:84:A6:E1:AE (Unknown)
Too many fingerprints match this host to give specific OS details
Network Distance: 1 hop

Nmap scan report for 10.33.78.129
Host is up (0.086s latency).

PORT     STATE    SERVICE
80/tcp   filtered http
554/tcp  filtered rtsp
9000/tcp filtered cslistener
MAC Address: 26:52:91:2B:F9:43 (Unknown)
Too many fingerprints match this host to give specific OS details
Network Distance: 1 hop

Nmap scan report for 10.33.78.130
Host is up (0.033s latency).

PORT     STATE  SERVICE
80/tcp   closed http
554/tcp  closed rtsp
9000/tcp closed cslistener
MAC Address: 3A:14:36:51:6E:2D (Unknown)
Too many fingerprints match this host to give specific OS details
Network Distance: 1 hop

Nmap scan report for 10.33.78.136
Host is up (0.15s latency).

PORT     STATE  SERVICE
80/tcp   closed http
554/tcp  closed rtsp
9000/tcp closed cslistener
MAC Address: 46:F9:D5:3D:8A:46 (Unknown)
Too many fingerprints match this host to give specific OS details
Network Distance: 1 hop

Nmap scan report for 10.33.78.137
Host is up (0.059s latency).

PORT     STATE  SERVICE
80/tcp   closed http
554/tcp  closed rtsp
9000/tcp closed cslistener
MAC Address: 64:A2:00:5C:F9:7A (Xiaomi Communications)
Too many fingerprints match this host to give specific OS details
Network Distance: 1 hop

Nmap scan report for 10.33.78.138
Host is up (0.90s latency).

PORT     STATE    SERVICE
80/tcp   filtered http
554/tcp  filtered rtsp
9000/tcp filtered cslistener
MAC Address: 56:4F:90:E9:CE:5B (Unknown)
Too many fingerprints match this host to give specific OS details
Network Distance: 1 hop

Nmap scan report for 10.33.78.139
Host is up (0.0074s latency).

PORT     STATE    SERVICE
80/tcp   filtered http
554/tcp  filtered rtsp
9000/tcp filtered cslistener
MAC Address: 90:09:DF:A4:67:21 (Intel Corporate)
Too many fingerprints match this host to give specific OS details
Network Distance: 1 hop

Nmap scan report for 10.33.78.141
Host is up (0.0050s latency).

PORT     STATE    SERVICE
80/tcp   filtered http
554/tcp  filtered rtsp
9000/tcp filtered cslistener
MAC Address: 4C:D5:77:E5:91:9D (Chongqing Fugui Electronics)
Too many fingerprints match this host to give specific OS details
Network Distance: 1 hop

Nmap scan report for 10.33.78.143
Host is up (0.0050s latency).

PORT     STATE    SERVICE
80/tcp   filtered http
554/tcp  filtered rtsp
9000/tcp filtered cslistener
MAC Address: 70:A8:D3:78:BE:BE (Intel Corporate)
Too many fingerprints match this host to give specific OS details
Network Distance: 1 hop

Nmap scan report for 10.33.78.145
Host is up (0.11s latency).

PORT     STATE    SERVICE
80/tcp   filtered http
554/tcp  filtered rtsp
9000/tcp filtered cslistener
MAC Address: 74:4C:A1:71:E3:F7 (Liteon Technology)
Too many fingerprints match this host to give specific OS details
Network Distance: 1 hop

Nmap scan report for 10.33.78.147
Host is up (0.16s latency).

PORT     STATE    SERVICE
80/tcp   filtered http
554/tcp  filtered rtsp
9000/tcp filtered cslistener
MAC Address: 94:BB:43:D9:E1:25 (Unknown)
Too many fingerprints match this host to give specific OS details
Network Distance: 1 hop

Nmap scan report for 10.33.78.150
Host is up (0.0086s latency).

PORT     STATE    SERVICE
80/tcp   filtered http
554/tcp  filtered rtsp
9000/tcp filtered cslistener
MAC Address: 7C:21:4A:E8:11:1A (Intel Corporate)
Too many fingerprints match this host to give specific OS details
Network Distance: 1 hop

Nmap scan report for 10.33.78.151
Host is up (0.043s latency).

PORT     STATE  SERVICE
80/tcp   closed http
554/tcp  closed rtsp
9000/tcp closed cslistener
MAC Address: 80:65:7C:D6:8A:A3 (Apple)
Too many fingerprints match this host to give specific OS details
Network Distance: 1 hop

Nmap scan report for 10.33.78.153
Host is up (0.043s latency).

PORT     STATE  SERVICE
80/tcp   closed http
554/tcp  closed rtsp
9000/tcp closed cslistener
MAC Address: B2:D9:6C:00:48:67 (Unknown)
Too many fingerprints match this host to give specific OS details
Network Distance: 1 hop

Nmap scan report for 10.33.78.155
Host is up (0.0077s latency).

PORT     STATE    SERVICE
80/tcp   filtered http
554/tcp  filtered rtsp
9000/tcp filtered cslistener
MAC Address: 28:C5:D2:67:28:89 (Intel Corporate)
Too many fingerprints match this host to give specific OS details
Network Distance: 1 hop

Nmap scan report for 10.33.78.157
Host is up (0.054s latency).

PORT     STATE  SERVICE
80/tcp   closed http
554/tcp  closed rtsp
9000/tcp closed cslistener
MAC Address: E6:9F:D1:5D:BB:A6 (Unknown)
Too many fingerprints match this host to give specific OS details
Network Distance: 1 hop

Nmap scan report for 10.33.78.159
Host is up (0.0034s latency).

PORT     STATE    SERVICE
80/tcp   filtered http
554/tcp  filtered rtsp
9000/tcp filtered cslistener
MAC Address: 30:F6:EF:E6:AD:98 (Intel Corporate)
Too many fingerprints match this host to give specific OS details
Network Distance: 1 hop

Nmap scan report for 10.33.78.160
Host is up (0.061s latency).

PORT     STATE  SERVICE
80/tcp   closed http
554/tcp  closed rtsp
9000/tcp closed cslistener
MAC Address: 14:7D:DA:BF:E0:D6 (Apple)
Too many fingerprints match this host to give specific OS details
Network Distance: 1 hop

Nmap scan report for 10.33.78.163
Host is up (0.049s latency).

PORT     STATE  SERVICE
80/tcp   closed http
554/tcp  closed rtsp
9000/tcp closed cslistener
MAC Address: 1A:8E:B5:98:77:38 (Unknown)
Too many fingerprints match this host to give specific OS details
Network Distance: 1 hop

Nmap scan report for 10.33.78.165
Host is up (0.066s latency).

PORT     STATE    SERVICE
80/tcp   filtered http
554/tcp  filtered rtsp
9000/tcp filtered cslistener
MAC Address: C0:35:32:E6:90:05 (Unknown)
Too many fingerprints match this host to give specific OS details
Network Distance: 1 hop

Nmap scan report for 10.33.78.166
Host is up (0.0061s latency).

PORT     STATE    SERVICE
80/tcp   filtered http
554/tcp  filtered rtsp
9000/tcp filtered cslistener
MAC Address: D0:65:78:37:D6:29 (Unknown)
Too many fingerprints match this host to give specific OS details
Network Distance: 1 hop

Nmap scan report for 10.33.78.168
Host is up (0.040s latency).

PORT     STATE  SERVICE
80/tcp   closed http
554/tcp  closed rtsp
9000/tcp closed cslistener
MAC Address: 60:3E:5F:5A:B2:43 (Unknown)
Too many fingerprints match this host to give specific OS details
Network Distance: 1 hop

Nmap scan report for 10.33.78.171
Host is up (0.048s latency).

PORT     STATE  SERVICE
80/tcp   closed http
554/tcp  closed rtsp
9000/tcp closed cslistener
MAC Address: A4:83:E7:75:7C:78 (Apple)
Too many fingerprints match this host to give specific OS details
Network Distance: 1 hop

Nmap scan report for 10.33.78.173
Host is up (0.76s latency).

PORT     STATE    SERVICE
80/tcp   filtered http
554/tcp  filtered rtsp
9000/tcp filtered cslistener
MAC Address: 5E:9E:B6:64:C4:52 (Unknown)
Too many fingerprints match this host to give specific OS details
Network Distance: 1 hop

Nmap scan report for 10.33.78.174
Host is up (0.78s latency).

PORT     STATE    SERVICE
80/tcp   filtered http
554/tcp  filtered rtsp
9000/tcp filtered cslistener
MAC Address: CA:00:68:9A:3C:0A (Unknown)
Too many fingerprints match this host to give specific OS details
Network Distance: 1 hop

Nmap scan report for 10.33.78.190
Host is up (0.46s latency).

PORT     STATE    SERVICE
80/tcp   filtered http
554/tcp  filtered rtsp
9000/tcp filtered cslistener
MAC Address: CE:38:75:32:40:75 (Unknown)
Too many fingerprints match this host to give specific OS details
Network Distance: 1 hop

Nmap scan report for 10.33.78.208
Host is up (0.011s latency).

PORT     STATE    SERVICE
80/tcp   open     http
554/tcp  filtered rtsp
9000/tcp filtered cslistener
MAC Address: BC:03:58:B5:3E:C5 (Intel Corporate)
Warning: OSScan results may be unreliable because we could not find at least 1 open and 1 closed port
Device type: general purpose|firewall
Running (JUST GUESSING): FreeBSD 6.X (95%), Microsoft Windows 10|2008 (93%), Juniper JUNOS 12.X|10.X (86%)
OS CPE: cpe:/o:freebsd:freebsd:6.2 cpe:/o:microsoft:windows_10 cpe:/o:microsoft:windows_server_2008::beta3 cpe:/o:microsoft:windows_server_2008 cpe:/o:freebsd:freebsd:6.3 cpe:/o:juniper:junos:12.1 cpe:/o:juniper:junos:10
Aggressive OS guesses: FreeBSD 6.2-RELEASE (95%), Microsoft Windows 10 (93%), Microsoft Windows Server 2008 or 2008 Beta 3 (91%), Microsoft Windows Server 2008 SP1 (87%), m0n0wall 1.3b11 - 1.3b15 (FreeBSD 6.3) (86%), Juniper SRX-series firewall (JUNOS 12.1) (86%), Microsoft Windows 10 1703 (86%), Microsoft Windows 10 1511 - 1607 (86%), Juniper SRX100-series or SRX200-series firewall (JUNOS 10.4 - 12.1) (85%)
No exact OS matches for host (test conditions non-ideal).
Network Distance: 1 hop

Nmap scan report for 10.33.78.230
Host is up (0.0049s latency).

PORT     STATE    SERVICE
80/tcp   filtered http
554/tcp  filtered rtsp
9000/tcp filtered cslistener
MAC Address: 50:5A:65:4E:04:CB (AzureWave Technologies)
Too many fingerprints match this host to give specific OS details
Network Distance: 1 hop

Nmap scan report for 10.33.78.231
Host is up (0.043s latency).

PORT     STATE    SERVICE
80/tcp   filtered http
554/tcp  filtered rtsp
9000/tcp filtered cslistener
MAC Address: 70:D8:23:D5:ED:D2 (Intel Corporate)
Too many fingerprints match this host to give specific OS details
Network Distance: 1 hop

Nmap scan report for 10.33.78.233
Host is up (0.0059s latency).

PORT     STATE    SERVICE
80/tcp   filtered http
554/tcp  filtered rtsp
9000/tcp filtered cslistener
MAC Address: F8:FE:5E:A5:67:93 (Unknown)
Too many fingerprints match this host to give specific OS details
Network Distance: 1 hop

Nmap scan report for 10.33.78.234
Host is up (0.0049s latency).

PORT     STATE    SERVICE
80/tcp   filtered http
554/tcp  filtered rtsp
9000/tcp filtered cslistener
MAC Address: 34:6F:24:E2:DA:27 (AzureWave Technology)
Too many fingerprints match this host to give specific OS details
Network Distance: 1 hop

Nmap scan report for 10.33.78.235
Host is up (0.0074s latency).

PORT     STATE    SERVICE
80/tcp   filtered http
554/tcp  filtered rtsp
9000/tcp filtered cslistener
MAC Address: 9C:FC:E8:79:F3:BA (Intel Corporate)
Too many fingerprints match this host to give specific OS details
Network Distance: 1 hop

Nmap scan report for 10.33.78.236
Host is up (0.0049s latency).

PORT     STATE    SERVICE
80/tcp   filtered http
554/tcp  filtered rtsp
9000/tcp filtered cslistener
MAC Address: 10:91:D1:24:98:E8 (Unknown)
Too many fingerprints match this host to give specific OS details
Network Distance: 1 hop

Nmap scan report for 10.33.78.238
Host is up (0.81s latency).

PORT     STATE    SERVICE
80/tcp   filtered http
554/tcp  filtered rtsp
9000/tcp filtered cslistener
MAC Address: 1A:CF:2F:B3:D7:D3 (Unknown)
Too many fingerprints match this host to give specific OS details
Network Distance: 1 hop

Nmap scan report for 10.33.78.246
Host is up (0.060s latency).

PORT     STATE    SERVICE
80/tcp   filtered http
554/tcp  filtered rtsp
9000/tcp filtered cslistener
MAC Address: 62:7E:0B:FB:EB:BD (Unknown)
Too many fingerprints match this host to give specific OS details
Network Distance: 1 hop

Nmap scan report for 10.33.78.247
Host is up (0.60s latency).

PORT     STATE    SERVICE
80/tcp   filtered http
554/tcp  filtered rtsp
9000/tcp filtered cslistener
MAC Address: 36:1B:3B:A0:6B:40 (Unknown)
Too many fingerprints match this host to give specific OS details
Network Distance: 1 hop

Nmap scan report for 10.33.78.249
Host is up (0.014s latency).

PORT     STATE  SERVICE
80/tcp   closed http
554/tcp  closed rtsp
9000/tcp closed cslistener
MAC Address: 2C:98:11:56:BF:F1 (Unknown)
Too many fingerprints match this host to give specific OS details
Network Distance: 1 hop

Nmap scan report for 10.33.78.250
Host is up (0.0066s latency).

PORT     STATE    SERVICE
80/tcp   filtered http
554/tcp  filtered rtsp
9000/tcp filtered cslistener
MAC Address: A8:41:F4:F1:62:4C (Unknown)
Too many fingerprints match this host to give specific OS details
Network Distance: 1 hop

Nmap scan report for 10.33.78.254
Host is up (0.0080s latency).

PORT     STATE  SERVICE
80/tcp   closed http
554/tcp  closed rtsp
9000/tcp closed cslistener
MAC Address: 1A:D3:B6:8C:7E:C0 (Unknown)
Too many fingerprints match this host to give specific OS details
Network Distance: 1 hop

OS detection performed. Please report any incorrect results at https://nmap.org/submit/ .
Nmap done: 256 IP addresses (54 hosts up) scanned in 312.09 seconds
```
- Ce que j'observe dans un premier temps, c'est que le port 80 est uniquement ouvert à l'appareil ayant l'adresse 10.33.78.67, sinon il est fermé ou filtré comme les ports 554 et 9000 ce qui laisse supposer qu'il y'a un pare-feu présent ou des controles d'accès sur ces appareils. Évidemment, plusieurs appareils ont leur adresses Mac identifiés mais le reste est inconnu, mais je ne vais pas aller plus loin pour faire des vérifications supplémentaire pour comprendre quels appareils sont sur mon réseau afin de rester dans le cadre du TP.

- En revanche, les appareils que je pense susceptible d'etre des cameras appartiennent aux IP 10.33.78.56 (le port RTSP étant filtré , cela peut signifier que l'appareil est configuré pour ignorer les requetes ou il qu'il y'a un pare-feu), 10.33.78.67(bien que le port RSTP est filtré, l'appareil est susceptible d'etre une caméra parce qu'il accepte les connexions au port 80 qui peut etre de ce fait un point d'accés pour les caméras réseau) et 10.33.78.96( bien que le port RSTP est filtré, il pourrait s'avérer etre un dispositif de surveillance).

🌞 Potentielles vulnérabilités

Je rappelle une nouvelle fois à travers ce rapport que ce travail a consisté uniquement à une prise d'information passive pour l'exercice d'une récolte d'informations et non d'autres choses. 

- Une attaque "Man In The Middle"(MITM) potentielle via les télévisions. En effet, la connexion au port 8000 se fait en http donc rien n'est sécurisé et encore moins chiffré. De ce fait, une attaque MITM pourrait se faire en faisant télécharger un fichier compromis à des fins malveillantes.

- Une autre attaque potentielle qui peut se faire au sein de l'école. En effet, dans le réseau auquel je me trouve, je constate que l'administrateur du réseau a opté pour l'utilisation du WPA2 Enterprise pour la sécurité du réseau WiFi. Mais, en commençant par un spoofing du réseau, puis installer un faux server, pour ensuite désauthentifier les cibles du réseau légitime, et passer par la collecte des données suite au forçage des cibles à se connecter au réseau monté de toute pièces, me voilà avoir réussi une attaque MITM.
