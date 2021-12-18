#!/bin/bash

echo "#### Nmap version"
nmap -v
echo "#### SQLMap version"
sqlmap --version
echo "#### John The Ripper version"
/usr/local/src/john/run/john --help | head -1
echo "#### Hydra version"
hydra -h | head -1
echo "#### Nikto version"
nikto.pl -Version | grep "Nikto main"
echo "#### PadBuster version"
padbuster -h 2>&1 | grep "PadBuster - "
echo "#### Aircrack-ng version"
aircrack-ng --help | grep "Aircrack-ng"
echo "#### WPScan version"
wpscan --version | grep "Current Version"
echo "#### Metasploit version"
msfconsole --version