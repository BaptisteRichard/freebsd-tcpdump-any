#!/bin/sh


if test $1 = '-h' -o $1 = '--help'
then
  echo "$0 : Capture traffic on all non-loopback interfaces with optionnal filter"
  echo "     Warning : Output might not be in perfect order, look carefully at timestamps or sort the output afterwards"
  echo "     Warning : Do no use -w flag, as only one tcpdump will be able to write to the file anyway"
  echo "Usage : $0 [--pretty|--write] [tcpdump filters]"
  echo "        --pretty : output packets with -nne flags and replace own mac addresses with interface names"
  echo "        --write : saves packets in current directory, under <ifname>.pcap for each interface"
  echo "Example : $0 icmp and host 8.8.8.8"
  echo "Example : $0 --pretty icmp and host 8.8.8.8"
  exit
fi

#print mode OFF
print=0
write=0
if test $1 = '--pretty'
then
  #set print mode ON
  print=1
  shift #remove first arg
elif test $1 = '--write'
then
  #set print mode ON
  write=1
  shift #remove first arg
fi

#For each running, non-loopback interfaces shown by tcpdump :
tcpdump --list-interfaces | grep Running | grep -v Loopback | cut -f 1 -d ' ' | cut -f 2- -d '.' | while read interface
do

  #Get interface mac address for coloration of own MACs
  mac=`ifconfig $interface | grep "ether*" | tr -d ' ' | tr -d '\t' | cut -c 6-42`
  pmac=`printf "%10s%7s" $interface`

  #Capture packets on this interface with different options

  if test $print -eq 1
  then
    #Pretty-print output

    #Option 1 : Replaces own macs by interfaces name for better visibility
    tcpdump -lnnei $interface "$@" | sed -e "s/$mac/$pmac/" &

    #Option 2 :Color own interfaces MACs
    #tcpdump -lnnei $interface "$@" | grep --color $mac &

  elif test $write -eq 1
  then
    #Write packets to separate files in working directory
    tcpdump -i $interface -w $interface.pcap "$@" &

  else

    #basic tcpdump with user custom arguments
    tcpdump -i $interface "$@" &

  fi

  #Get tcpdump pid for later use
  pid=$!

  #Register a SINGINT trap to kill the sub tcpdump before exiting
  trap "kill $pid ; exit" SIGINT

done

#sleep until SINGINT is caught
while true
do
sleep 300
done
