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
     
Example : ./tcpdump-any.sh --pretty icmp and host 8.8.8.8

# Warning !
Tcpdump filters from user input are not parsed and might lead to privilege escalation or other undesirable effects if unproperly used.
  
This script is intended for use by the device administrators with standard account and basic tcpdump knowledge
