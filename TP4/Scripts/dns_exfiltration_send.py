from scapy.all import *
import sys

def sendMessage(target_ip, message):
    packet = IP(dst=target_ip) / UDP(dport=53) / DNS(rd=1, qd=DNSQR(qname=message))
    send(packet)

if len(sys.argv) < 3:
    print("Usage: python script.py <target_ip> <message>")
    exit()

target_ip = sys.argv[1]
message = str(sys.argv[2]).replace('.', '°')
segments = [message[i:i + 6] for i in range(0, len(message), 6)]

for count, segment in enumerate(segments):
    sendMessage(target_ip, f"{count}~{segment}~{target_ip}")

sendMessage(target_ip, f"~~end~~.{target_ip}")
