#!/bin/bash

#Time
echo ""
echo "[+]Time[+]"
echo

echo "- Current system date and time: " | sed 's/^/   /'
echo
date | sed 's/^/      /'
echo

echo "- PC uptime:" | sed 's/^/   /'
echo
uptime | sed 's/^/      /'
echo ""

#OS version
echo "[+]OS version[+]"
echo
echo "- Operating-system and processor: " | sed 's/^/   /'
echo
uname -o -p | sed 's/^/      /'
echo
echo "- Typical name: " | sed 's/^/   /'
echo
uname -n | sed 's/^/      /'
echo
echo "- Kernel version: " | sed 's/^/   /'
echo
uname -v | sed 's/^/      /'
echo ""

#System specs
echo "[+]System specs[+]"
echo
echo "- CPU architecture: " | sed 's/^/   /'
echo
lscpu | head -n 5 | sed 's/^/      /'
echo

echo "- System memory information: " | sed 's/^/   /'
echo
free -h | sed 's/^/      /'
echo

echo "- File system information: " | sed 's/^/   /'
echo
df -h | sed 's/^/      /'
echo

echo "- Partitions: " | sed 's/^/   /'
echo
lsblk | sed 's/^/      /'
echo

echo "- Hostname: " | sed 's/^/   /'
echo

hostname | sed 's/^/      /'
echo

echo "- Domainname: " | sed 's/^/   /'


hostname -d | sed 's/^/      /'
echo ""

#Network
echo "[+]Network[+]"
echo
echo "- MAC addresses: " | sed 's/^/   /'
ip link | awk '{print $2}' | sed 's/^/      /'
echo

echo "- IP address: " | sed 's/^/   /'
echo
ip -o a show | cut -d ' ' -f 2,7 | sed 's/^/      /'
echo

echo "- promiscuous mode?: " | sed 's/^/   /'
echo
netstat -i | awk 'NR > 2 { if($11 ~ /[P]/){print $1, "yes"} else {print $1, "no"}}' | sed 's/^/      /'
echo

echo "- Established network connections: " | sed 's/^/   /'
echo
netstat -natu | grep 'ESTABLISHED' | sed 's/^/      /'
echo ""

#Users
echo "[+]Users[+]"
echo
echo "- Currently logged in users: " | sed 's/^/   /'
echo
who | sed 's/^/      /'
echo

echo "- Users who logged in (and out) of the system: " | sed 's/^/   /'
echo
last | sed 's/^/      /'
echo

echo "- Users with uid=0: " | sed 's/^/   /'
echo
cat /etc/passwd | grep ":0:" | sed "s/:x:.*//" | sed 's/^/      /'
echo

echo "- Root-owned (uid=0) SUID files: " | sed 's/^/   /'
echo
sudo find / -user root -perm -u=s -type f 2>/dev/null | sed 's/^/      /'
echo ""

#Processes and open files
echo "[+]Processes and open files[+]"
echo
echo "- processes: " | sed 's/^/   /'
ps -ef | head -n 5  | sed 's/^/      /'
echo

echo "- Files opened by 'nc': " | sed 's/^/   /'
echo
lsof -c nc 2>/dev/null  | sed 's/^/      /'
echo

echo "- opened but unlinked files (deleted): " | sed 's/^/   /'
echo
lsof -nP +L1 2>/dev/null | sed 's/^/      /'
echo ""

#Other miscellaneous
echo "[+]Other miscellaneous[+]"
echo
echo "- files modified in the last 24 hours: " | sed 's/^/   /'
echo
sudo find ~ -mtime -1 -ls | head -n 5 | sed 's/^/      /'
echo

echo "- scheduled tasks for root: " | sed 's/^/   /'
echo
sudo crontab -u root -l | sed 's/^/      /'
echo

#other info
echo "- processes associated with specific services: " | sed 's/^/   /'
echo
systemd-cgtop | head -n 5 | sed 's/^/      /'
echo

echo "- Login attempts: " | sed 's/^/   /'
echo
cat /var/log/auth.log | tail -n 5 | sed 's/^/      /'
echo

echo "- iptables: " | sed 's/^/   /'
echo
sudo iptables -L -n | head -n 5 | sed 's/^/      /'
echo
