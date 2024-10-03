TP2 : Environnement virtuel

I. Topologie réseau

☀️ Sur node1.lan1.tp2

```
- Affichage des cartes réseaux : 

[amine@node1-lan1-tp2 ~]$ ip a
1: lo: <LOOPBACK,UP,LOWER_UP> mtu 65536 qdisc noqueue state UNKNOWN group default qlen 1000
    link/loopback 00:00:00:00:00:00 brd 00:00:00:00:00:00
    inet 127.0.0.1/8 scope host lo
       valid_lft forever preferred_lft forever
    inet6 ::1/128 scope host 
       valid_lft forever preferred_lft forever
2: enp0s8: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc fq_codel state UP group default qlen 1000
    link/ether 08:00:27:14:7e:a7 brd ff:ff:ff:ff:ff:ff
    inet 10.1.1.11/24 brd 10.1.1.255 scope global noprefixroute enp0s8
       valid_lft forever preferred_lft forever
    inet6 fe80::a00:27ff:fe14:7ea7/64 scope link noprefixroute 
       valid_lft forever preferred_lft forever

```
```
- Affichage de sa table de routage :
[amine@node1-lan1-tp2 ~]$ ip r s
default via 255.255.255.0 dev enp0s8 proto static metric 100 
10.1.1.0/24 dev enp0s8 proto kernel scope link src 10.1.1.11 metric 100 
10.1.2.0/24 via 10.1.1.254 dev enp0s8 
255.255.255.0 dev enp0s8 proto static scope link metric 100

```
```
- Joindre node2.lan2.tp2 :
[amine@node1-lan1-tp2 ~]$ ping 10.1.2.11
PING 10.1.2.11 (10.1.2.11) 56(84) bytes of data.
64 bytes from 10.1.2.11: icmp_seq=1 ttl=63 time=0.512 ms
64 bytes from 10.1.2.11: icmp_seq=2 ttl=63 time=1.10 ms
64 bytes from 10.1.2.11: icmp_seq=3 ttl=63 time=0.678 ms
64 bytes from 10.1.2.11: icmp_seq=4 ttl=63 time=0.492 ms
^C
--- 10.1.2.11 ping statistics ---
4 packets transmitted, 4 received, 0% packet loss, time 3099ms
rtt min/avg/max/mdev = 0.492/0.695/1.103/0.255 ms

```
```
- Prouver que le paquet passe par router.tp2 avec traceroute : 
[amine@node1-lan1-tp2 ~]$ traceroute 10.1.2.11
traceroute to 10.1.2.11 (10.1.2.11), 30 hops max, 60 byte packets
 1  10.1.1.254 (10.1.1.254)  0.342 ms  0.310 ms  0.319 ms
 2  10.1.2.11 (10.1.2.11)  125.457 ms !X  125.463 ms !X  125.452 ms !X

```
II. Interlude accès internet

☀️ Sur router.tp2

```
[amine@router-tp2 ~]$ ping 8.8.8.8
PING 8.8.8.8 (8.8.8.8) 56(84) bytes of data.
64 bytes from 8.8.8.8: icmp_seq=1 ttl=63 time=245 ms
64 bytes from 8.8.8.8: icmp_seq=2 ttl=63 time=58.2 ms
64 bytes from 8.8.8.8: icmp_seq=3 ttl=63 time=198 ms
64 bytes from 8.8.8.8: icmp_seq=4 ttl=63 time=72.5 ms
^C
--- 8.8.8.8 ping statistics ---
4 packets transmitted, 4 received, 0% packet loss, time 3002ms
rtt min/avg/max/mdev = 58.200/143.675/245.451/68.102 ms

```
```
[amine@router-tp2 ~]$ ping google.com
PING google.com (172.217.20.206) 56(84) bytes of data.
64 bytes from par10s50-in-f14.1e100.net (172.217.20.206): icmp_seq=1 ttl=63 time=48.5 ms
64 bytes from waw02s08-in-f14.1e100.net (172.217.20.206): icmp_seq=2 ttl=63 time=162 ms
64 bytes from par10s50-in-f14.1e100.net (172.217.20.206): icmp_seq=3 ttl=63 time=275 ms
64 bytes from waw02s08-in-f206.1e100.net (172.217.20.206): icmp_seq=4 ttl=63 time=109 ms
64 bytes from waw02s08-in-f206.1e100.net (172.217.20.206): icmp_seq=5 ttl=63 time=111 ms
^C
--- google.com ping statistics ---
5 packets transmitted, 5 received, 0% packet loss, time 4001ms
rtt min/avg/max/mdev = 48.500/141.260/275.123/69.457 ms

```

☀️ Accès internet LAN1 et LAN2

```
[amine@node2-lan1-tp2 ~]$ ping 8.8.8.8
PING 8.8.8.8 (8.8.8.8) 56(84) bytes of data.
64 bytes from 8.8.8.8: icmp_seq=1 ttl=61 time=265 ms
64 bytes from 8.8.8.8: icmp_seq=2 ttl=61 time=182 ms
64 bytes from 8.8.8.8: icmp_seq=3 ttl=61 time=104 ms
64 bytes from 8.8.8.8: icmp_seq=4 ttl=61 time=55.3 ms
^C
--- 8.8.8.8 ping statistics ---
4 packets transmitted, 4 received, 0% packet loss, time 3002ms
rtt min/avg/max/mdev = 51.300/153.200/265.000/81.700 ms

```
```
[amine@node2-lan1-tp2 ~]$ ping google.com
PING google.com (172.217.20.174) 56(84) bytes of data.
64 bytes from par10s49-in-f14.1e100.net (172.217.20.174): icmp_seq=1 ttl=61 time=66.4 ms
64 bytes from waw02s07-in-f174.1e100.net (172.217.20.174): icmp_seq=2 ttl=61 time=140 ms
64 bytes from waw02s07-in-f174.1e100.net (172.217.20.174): icmp_seq=3 ttl=61 time=62.1 ms
64 bytes from waw02s07-in-f14.1e100.net (172.217.20.174): icmp_seq=4 ttl=61 time=290 ms
^C
--- google.com ping statistics ---
4 packets transmitted, 4 received, 0% packet loss, time 7090ms
rtt min/avg/max/mdev = 62.104/139.227/290.123/89.340 ms

```

III. Services réseau

1. Web web web

☀️ Sur web.lan2.tp2

```
[amine@web-lan2-tp2 ~]$ cat /var/www/site_null/index.html 
Site nul de ouf

```
```
[amine@web-lan2-tp2 ~]$ sudo systemctl status nginx
[sudo] password for amine: 
● nginx.service - The nginx HTTP and reverse proxy server
     Loaded: loaded (/usr/lib/systemd/system/nginx.service; enabled; preset: disabled)
     Active: active (running) since Fri 2024-10-04 11:26:48 CEST; 1min 8s ago
    Process: 785 ExecStartPre=/usr/bin/rm -f /run/nginx.pid (code=exited, status=0/SUCCESS)
    Process: 787 ExecStartPre=/usr/sbin/nginx -t (code=exited, status=0/SUCCESS)
    Process: 793 ExecStart=/usr/sbin/nginx (code=exited, status=0/SUCCESS)
   Main PID: 794 (nginx)
      Tasks: 2 (limit: 4611)
     Memory: 3.7M
        CPU: 12ms
     CGroup: /system.slice/nginx.service
             ├─794 "nginx: master process /usr/sbin/nginx"
             └─798 "nginx: worker process"

Oct 04 11:26:48 web-lan2-tp2 systemd[1]: Starting The nginx HTTP and reverse proxy server...
Oct 04 11:26:48 web-lan2-tp2 nginx[787]: nginx: the configuration file /etc/nginx/nginx.conf syntax is ok
Oct 04 11:26:48 web-lan2-tp2 nginx[787]: nginx: configuration file /etc/nginx/nginx.conf test is successful
Oct 04 11:26:48 web-lan2-tp2 systemd[1]: Started The nginx HTTP and reverse proxy server.

```
```
[amine@web-lan2-tp2 ~]$ ss -tupnl | grep 80
tcp   LISTEN 0      511          0.0.0.0:80        0.0.0.0:*          
tcp   LISTEN 0      511             [::]:80           [::]:*     

```
```
[amine@node2-lan2-tp2 ~]$ sudo firewall-cmd --list-all
public (active)
  target: default
  icmp-block-inversion: no
  interfaces: enp0s8
  sources: 
  services: cockpit dhcpv6-client ssh
  ports: 80/tcp
  protocols: 
  forward: yes
  masquerade: no
  forward-ports: 
  source-ports: 
  icmp-blocks: 
  rich rules: 

```
☀️ Sur node1.lan1.tp2

```
[amine@node1-lan1-tp2 ~]$ curl site_nul.tp2
<p> SUPER SITE INTERNET</p>
[amine@node1-lan1-tp2 ~]$ cat /etc/hosts
127.0.0.1   localhost localhost.localdomain localhost4 localhost4.localdomain4
::1         localhost localhost.localdomain localhost6 localhost6.localdomain6
10.1.2.12   site_nul.tp2

```
```
[amine@node1-lan1-tp2 ~]$ curl site_nul.tp2
<p> SUPER SITE INTERNET</p>

```

2. Or is it ? Bonus : DHCP

☀️ Sur dhcp.lan1.tp2

```
[amine@dhcp-lan1-tp2 ~]$ sudo cat /etc/dhcp/dhcpd.conf
#
# DHCP Server Configuration file.
#   see /usr/share/doc/dhcp-server/dhcpd.conf.example
#   see dhcpd.conf(5) man page
#
default-lease-time 900;
max-lease-time 10800;

authoritative;

subnet 10.1.1.0 netmask 255.255.255.0 {
    range 10.1.1.100 10.1.1.200;
    option routers 10.1.1.254;
    option subnet-mask 255.255.255.0;
    option domain-name-servers 1.1.1.1;
}

```
```
[amine@dhcp-lan1-tp2 ~]$ sudo systemctl status dhcpd
● dhcpd.service - DHCPv4 Server Daemon
     Loaded: loaded (/usr/lib/systemd/system/dhcpd.service; enabled; preset: disabled)
     Active: active (running) since Fri 2024-10-04 00:47:17 CEST; 1min 52s ago
       Docs: man:dhcpd(8)
             man:dhcpd.conf(5)
   Main PID: 784 (dhcpd)
     Status: "Dispatching packets..."
      Tasks: 1 (limit: 4611)
     Memory: 7.1M
        CPU: 8ms
     CGroup: /system.slice/dhcpd.service
             └─784 /usr/sbin/dhcpd -f -cf /etc/dhcp/dhcpd.conf -user dhcpd -group dhcpd --no-pid

Oct 04 00:47:17 dhcp-lan1-tp2 dhcpd[784]: Config file: /etc/dhcp/dhcpd.conf
Oct 04 00:47:17 dhcp-lan1-tp2 dhcpd[784]: Database file: /var/lib/dhcpd/dhcpd.leases
Oct 04 00:47:17 dhcp-lan1-tp2 dhcpd[784]: PID file: /var/run/dhcpd.pid
Oct 04 00:47:17 dhcp-lan1-tp2 dhcpd[784]: Source compiled to use binary-leases
Oct 04 00:47:17 dhcp-lan1-tp2 dhcpd[784]: Wrote 0 leases to leases file.
Oct 04 00:47:17 dhcp-lan1-tp2 dhcpd[784]: Listening on LPF/enp0s8/08:00:27:0b:6e:0a/10.1.1.0/24
Oct 04 00:47:17 dhcp-lan1-tp2 dhcpd[784]: Sending on   LPF/enp0s8/08:00:27:0b:6e:0a/10.1.1.0/24
Oct 04 00:47:17 dhcp-lan1-tp2 dhcpd[784]: Sending on   Socket/fallback/fallback-net
Oct 04 00:47:17 dhcp-lan1-tp2 dhcpd[784]: Server starting service.
Oct 04 00:47:17 dhcp-lan1-tp2 systemd[1]: Started DHCPv4 Server Daemon.

```

☀️ Sur node1.lan1.tp2

```
[amine@node1-lan1-tp2 ~]$ sudo systemctl restart NetworkManager
[amine@node1-lan1-tp2 ~]$ ip a 
1: lo: <LOOPBACK,UP,LOWER_UP> mtu 65536 qdisc noqueue state UNKNOWN group default qlen 1000
    link/loopback 00:00:00:00:00:00 brd 00:00:00:00:00:00
    inet 127.0.0.1/8 scope host lo
       valid_lft forever preferred_lft forever
    inet6 ::1/128 scope host 
       valid_lft forever preferred_lft forever
2: enp0s8: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc fq_codel state UP group default qlen 1000
    link/ether 08:00:27:14:7e:b1 brd ff:ff:ff:ff:ff:ff
    inet 10.1.1.100/24 brd 10.1.1.255 scope global secondary dynamic noprefixroute enp0s8
       valid_lft 600sec preferred_lft 600sec
    inet6 fe80::a00:27ff:fe14:7eb1/64 scope link noprefixroute 
       valid_lft forever preferred_lft forever

```

```
[amine@node1-lan1-tp2 ~]$ ping 10.1.2.11
PING 10.1.2.11 (10.1.2.11) 56(84) bytes of data.
64 bytes from 10.1.2.11: icmp_seq=1 ttl=63 time=0.725 ms
64 bytes from 10.1.2.11: icmp_seq=2 ttl=63 time=1.12 ms
64 bytes from 10.1.2.11: icmp_seq=3 ttl=63 time=0.532 ms
64 bytes from 10.1.2.11: icmp_seq=4 ttl=63 time=1.11 ms
^C
--- 10.1.2.11 ping statistics ---
4 packets transmitted, 4 received, 0% packet loss, time 3052ms
rtt min/avg/max/mdev = 0.532/0.845/1.120/0.228 ms

```