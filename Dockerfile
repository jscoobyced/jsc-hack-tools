FROM gcc:latest AS build-env

WORKDIR /opt
RUN wget https://sourceforge.net/projects/netcat/files/latest/download -O netcat-0.7.1.tar.gz \
    && gunzip netcat-0.7.1.tar.gz \
    && tar -xvf netcat-0.7.1.tar
RUN cd netcat-0.7.1 \
    && ./configure --prefix=/opt/nc \
    && make \
    && make install

FROM debian:bullseye-slim

ENV DEBIAN_FRONTEND=noninteractive

LABEL maintainer="JscDroidDev"

ENV TZ Asia/Bangkok

WORKDIR /tmp

# Upgrade environment
RUN apt-get update && apt-get install apt-utils -y
RUN apt-get install locales wget -y \
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
    zlib1g-dev yasm pkg-config libgmp-dev libpcap-dev libbz2-dev \
    ruby ruby-dev
RUN update-alternatives --install /usr/bin/python python /usr/bin/python3 1

# Install hacking tools
RUN apt-get install -y hydra-gtk nmap aircrack-ng

RUN wget -q https://gitlab.com/kalilinux/packages/padbuster/-/raw/kali/master/padBuster.pl -O /usr/bin/padbuster \
    && chmod u+x /usr/bin/padbuster

RUN cd /usr/local/src && git clone https://github.com/sqlmapproject/sqlmap.git \
    && cd sqlmap && chmod 755 sqlmap.py

RUN update-alternatives --install /usr/bin/sqlmap sqlmap /usr/local/src/sqlmap/sqlmap.py 1

RUN cd /usr/local/src/ && git clone https://github.com/openwall/john -b bleeding-jumbo john
RUN cd /usr/local/src/john/src && ./configure && make -s clean && make -sj4
RUN echo "alias john=/usr/local/src/john/run/john" >> ~/.bashrc

RUN cd /usr/local/src/ && git clone https://github.com/sullo/nikto nikto
RUN update-alternatives --install /usr/bin/nikto.pl nikto /usr/local/src/nikto/program/nikto.pl 1

RUN gem install wpscan

RUN wget -q https://raw.githubusercontent.com/rapid7/metasploit-omnibus/master/config/templates/metasploit-framework-wrappers/msfupdate.erb -O msfinstall && \
  chmod 755 msfinstall && \
  ./msfinstall

RUN mkdir /opt/nc
COPY --from=build-env /opt/nc /opt/nc/
RUN update-alternatives --install /usr/bin/nc nc /opt/nc/bin/nc 1

RUN mkdir /usr/share/wordlist
COPY wordlist /usr/share/wordlist/
COPY versions.sh /usr/local/bin
RUN chmod 755 /usr/local/bin/versions.sh

# Cleanup
RUN rm -Rf /var/cache/apt/ /tmp/msfinstall

WORKDIR /opt