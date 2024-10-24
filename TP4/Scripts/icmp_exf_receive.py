from scapy.all import sniff, ICMP

def print_it_please(packet):
    if packet.haslayer(ICMP) and packet[ICMP].type == 8 and len(packet[Raw]) == 1:
        print(packet[Raw].load)
        quit()

sniff(filter="icmp", prn=print_it_please, count=0)
