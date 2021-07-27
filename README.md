# freebsd-tcpdump-any
Capture traffic on all interfaces on FreeBSD systems such as PfSense

./tcpdump-any.sh : Capture traffic on all non-loopback interfaces with optionnal filter

     Warning : Output might not be in perfect order, look carefully at timestamps or sort the output afterwards
     
     Warning : Do no use -w flag, as only one tcpdump will be able to write to the file anyway
    
# Usage
Usage : ./tcpdump-any.sh [--pretty|--write] [tcpdump filters]

        --pretty : output packets with -nne flags and replace own mac addresses with interface names
        
        --write : saves packets in current directory, under <ifname>.pcap for each interface

# Examples

Example : ./tcpdump-any.sh icmp and host 8.8.8.8
     
Example 2 with pretty printing
```
./tcpdump-any.sh --pretty icmp and host 8.8.8.8
11:58:30.826658       vmx0        > 24:16:9d:8a:5f:bf, ethertype IPv4 (0x0800), length 98: 10.1.1.1 > 8.8.8.8: ICMP echo request, id 46266, seq 3611, length 64
11:58:30.826800 24:16:9d:8a:5f:bf >       vmx0       , ethertype IPv4 (0x0800), length 98: 8.8.8.8 > 10.1.1.1: ICMP echo reply, id 46266, seq 3611, length 64
11:58:30.826625 e8:39:35:1f:06:c0 >       vmx1       , ethertype IPv4 (0x0800), length 98: 10.1.1.1 > 8.8.8.8: ICMP echo request, id 46266, seq 3611, length 64
11:58:30.826823       vmx1        > e8:39:35:1f:06:c0, ethertype IPv4 (0x0800), length 98: 8.8.8.8 > 10.1.1.1: ICMP echo reply, id 46266, seq 3611, length 64
11:58:31.826658       vmx0        > 24:16:9d:8a:5f:bf, ethertype IPv4 (0x0800), length 98: 10.1.1.1 > 8.8.8.8: ICMP echo request, id 46266, seq 3612, length 64
11:58:31.826815 24:16:9d:8a:5f:bf >       vmx0       , ethertype IPv4 (0x0800), length 98: 8.8.8.8 > 10.1.1.1: ICMP echo reply, id 46266, seq 3612, length 64
11:58:31.826654 e8:39:35:1f:06:c0 >       vmx1       , ethertype IPv4 (0x0800), length 98: 10.1.1.1 > 8.8.8.8: ICMP echo request, id 46266, seq 3612, length 64
11:58:31.826819       vmx1        > e8:39:35:1f:06:c0, ethertype IPv4 (0x0800), length 98: 8.8.8.8 > 10.1.1.1: ICMP echo reply, id 46266, seq 3612, length 64
``` 

# Warning !
Tcpdump filters from user input are not parsed and might lead to privilege escalation or other undesirable effects if unproperly used.
  
This script is intended for use by the device administrators with standard account and basic tcpdump knowledge
