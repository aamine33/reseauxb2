from scapy.all import sniff, DNS, DNSRR

def print_ip_address(packet):
    if DNS in packet and packet[DNS].qr == 1:
        for answer in packet[DNS].an:
            print(answer.rdata)

def print_result(packet):
    if DNSRR in packet:
        for i in range(packet.ancount):
            print(packet[DNS].an[i].rdata, end=" ; ")
        print()

sniff(filter="udp and port 53", prn=print_result, count=2)
sniff(filter="udp and port 53", prn=print_ip_address)
