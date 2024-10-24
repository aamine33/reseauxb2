from scapy.all import IP, ICMP, send
import sys

if len(sys.argv) != 3:
    print("Usage: python script.py <destination_ip> <message>")
    sys.exit(1)

packet = IP(dst=sys.argv[1]) / ICMP() / str(sys.argv[2])
send(packet)
