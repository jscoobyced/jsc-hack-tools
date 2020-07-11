FROM debian:buster-slim

ENV DEBIAN_FRONTEND=noninteractive

LABEL maintainer="JscDroidDev"

# Upgrade environment
RUN apt-get update \
    && apt-get install apt-utils locales wget -y \
    && apt-get upgrade -y \
    && apt-get autoremove --purge -y

# Setup environment
RUN sed -i -e 's/# en_US.UTF-8 UTF-8/en_US.UTF-8 UTF-8/' /etc/locale.gen \
    && locale-gen
ENV LANG en_US.UTF-8
ENV LANGUAGE en_US:en
ENV LC_ALL en_US.UTF-8
RUN sed -i 's/\# PS1/PS1/g' ~/.bashrc
RUN sed -i 's/\# alias ll/alias ll/g' ~/.bashrc

# Install basic tools
RUN apt-get install -y libwww-perl libcrypt-ssleay-perl \
    vim curl git python3 build-essential libssl-dev \
    zlib1g-dev yasm pkg-config libgmp-dev libpcap-dev libbz2-dev
RUN update-alternatives --install /usr/bin/python python /usr/bin/python3 1

#RUN mkdir /usr/share/wordlist
#COPY wordlist /usr/share/wordlist/

# Install hacking tools
RUN apt-get install -y hydra-gtk nmap aircrack-ng

RUN wget -q https://gitlab.com/kalilinux/packages/padbuster/-/raw/kali/master/padBuster.pl -O /usr/bin/padbuster \
    && chmod u+x /usr/bin/padbuster

RUN cd /usr/local/src && git clone https://github.com/sqlmapproject/sqlmap.git \
    && cd sqlmap && chmod 755 sqlmap.py

RUN update-alternatives --install /usr/bin/sqlmap sqlmap /usr/local/src/sqlmap/sqlmap.py 1

RUN cd /usr/local/src/ && git clone https://github.com/magnumripper/JohnTheRipper -b bleeding-jumbo john
RUN cd /usr/local/src/john/src && ./configure && make -s clean && make -sj4
RUN echo "alias john='/usr/local/src/john/run/john'" >> /root/.bashrc

RUN cd /usr/local/src/ && git clone https://github.com/sullo/nikto nikto
RUN echo "alias nikto='/usr/local/src/nikto/program/nikto.pl'" >> /root/.bashrc

# Cleanup
RUN rm -Rf /var/cache/apt/