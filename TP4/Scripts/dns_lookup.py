from scapy.all import *

def dns_query(query_domain, dns_server="8.8.8.8"):
    dns_request = IP(dst=dns_server) / UDP(dport=53) / DNS(rd=1, qd=DNSQR(qname=query_domain))
    answer = sr1(dns_request, verbose=0)

    if DNSRR in answer:
        for i in range(answer.ancount):
            print(answer.an[i].rdata, end=" ; ")
        print()

domain_to_query = "ynov.com"
dns_query(domain_to_query)
