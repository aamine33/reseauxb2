from scapy.all import *

ping = ICMP(type=8)
packet1 = IP(src="192.168.1.71", dst="192.168.1.99")
frame1 = Ether(src="b0:3c:dc:ae:ab:6e", dst="74:8f:3c:be:6e:b6")
final_frame1 = frame1 / packet1 / ping
answers1, unanswered1 = srp(final_frame1, timeout=10)

packet2 = IP(src="192.168.56.5", dst="192.168.56.1")
final_frame2 = packet2 / ping
answers2, unanswered2 = sr(final_frame2, timeout=10)

print("Begin emission:")
print(f"Finished sending {len(answers1) + len(unanswered1)} packets.")

print(f"\nReceived {len(answers2) + len(unanswered2)} packets, got {len(answers2)} answers, remaining {len(unanswered2)} packets")
print("Answers :")
for answer in answers2:
    print(f" - {answer}")
