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
