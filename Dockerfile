FROM telegraf

RUN apt-get update
RUN apt-get install -y build-essential git cmake protobuf-compiler python3

WORKDIR /opt

RUN git clone https://github.com/RadeonOpenCompute/rocm_smi_lib.git

RUN mkdir -p build

WORKDIR /opt/build

RUN cmake /opt/rocm_smi_lib/

RUN make install


