FROM centos:8.1.1911
RUN dnf -y update

RUN dnf -y groupinstall "Development tools"
RUN dnf -y config-manager --set-enabled PowerTools
RUN dnf -y install ninja-build zlib-devel openssl-devel git wget
RUN curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- --default-toolchain nightly -y


RUN useradd ton
RUN su ton
RUN cd
