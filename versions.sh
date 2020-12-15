#!/bin/bash

nmap -v
sqlmap --version
john --help | head -1
hydra -h | head -1
nikto -Version | grep "Nikto main"
padbuster -h 2>&1 | grep "PadBuster - "
wpscan --version | grep "Current Version"