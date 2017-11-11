# docker build -t multichain-lab .
# docker run -d --name node1 --rm -p 80:80 -m 64m multichain-lab
# docker run -d --name node2 --rm -m 48m -e MC_FIRST=chain1@172.17.0.2:2510 multichain-lab

FROM centos

RUN yum -y upgrade \
    && yum -y update \
    && yum -y install epel-release \
    && yum -y update \
    && yum -y install wget git httpd php \
    \
    && wget https://www.multichain.com/download/multichain-latest.tar.gz \
    && cd / && tar zxvf multichain-latest.tar.gz \
    && mv /multichain-1*/mu* /usr/bin \
    && /usr/bin/multichain-util create chain1 -default-network-port=2510 -default-rpc-port=2511 \
    && rm -f /multichain-latest.tar.gz \
    \
    && cd / && git clone https://github.com/MultiChain/multichain-web-demo.git \
    && mv /multichain-web-demo/* /var/www/html/ \
    && cd /var/www/html/ \
    && awk 'BEGIN { FS="="; pw="t"} /^rpcpassword/ { a=$2; next;} /^rpcuser.*/ { next ;} /default.rpcport=12345/ { print "default.rpcport=2511";next; } /rpcpa/ { printf("%s=%s",$1,a); next; } { print $0; }' ~/.multichain/chain1/multichain.conf config-example.txt > config.txt

COPY start.sh /start.sh
RUN chmod 755 /start.sh

EXPOSE 80
ENTRYPOINT /start.sh
