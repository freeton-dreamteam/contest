FROM centos:8.1.1911
RUN dnf -y update

RUN dnf -y groupinstall "Development tools"
RUN dnf -y config-manager --set-enabled PowerTools
RUN dnf -y install ninja-build zlib-devel openssl-devel git wget sudo cmake jq

RUN curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- --default-toolchain nightly -y
RUN cp /root/.rustup/toolchains/nightly-x86_64-unknown-linux-gnu/bin/* /bin/
RUN cp /root/.rustup/toolchains/nightly-x86_64-unknown-linux-gnu/lib/* /lib64/ -r
RUN cp /root/.rustup/toolchains/nightly-x86_64-unknown-linux-gnu/lib/rustlib /lib/ -r

RUN useradd ton
USER ton
WORKDIR /home/ton
RUN git clone https://github.com/tonlabs/net.ton.dev.git
WORKDIR /home/ton/net.ton.dev/scripts
RUN . ./env.sh
RUN ./build.sh
RUN cat /dev/null > ./env.sh

COPY setup-in-k8s.sh /home/ton/net.ton.dev/scripts/setup-in-k8s.sh
COPY validator-msig-in-k8s.sh /home/ton/net.ton.dev/scripts/validator-msig-in-k8s.sh
COPY confirmator-msig-in-k8s.sh /home/ton/net.ton.dev/scripts/confirmator-msig-in-k8s.sh


RUN dnf -y install epel-release
RUN dnf -y install logrotate cronie htop
RUN rpm -i http://repo.zabbix.com/zabbix/5.0/rhel/8/x86_64/zabbix-agent2-5.0.1-1.el8.x86_64.rpm
COPY ./../zabbix/zabbix_agent2.conf /etc/zabbix/zabbix_agent2.conf
COPY ./../zabbix/etc/zabbix/* /etc/zabbix/
COPY ./../zabbix/do.sh /home/ton
COPY ./../zabbix/cron /home/ton
RUN mkdir /var/lib/ton-metrics
RUN chown `ton`:`ton` /var/lib/ton-metrics
