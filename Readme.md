# Telegraf rocm_smi

Implementation of AMD ROCm System Management Interface (SMI) Input Plugin plugin in a docker container

# Usage

- Clone this repo

- Build the image `docker build -t telegraf-rocm .` or pull the image `docker pull toodaniels/telegraf-rocm`

- Run with /dev/dri/ volume

``` sh
    docker run -ti --device /dev/dri/:/dev/dri/ toodaniels/telegraf-rocm /opt/rocm/bin/rocm-smi --showid
```

## Compose 

``` yml
---
version: '3.8'
services:

    influxdb:
        image: influxdb:2.6-alpine
        env_file:
        - influxv2.env
        volumes:
        # Mount for influxdb data directory and configuration
        - influxdbv2:/var/lib/influxdb2:rw
        ports:
        - "8086:8086"
    telegraf:
        iamge: toodaniels/telegraf-rocm
        devices:
        - /dev/dri/:/dev/dri/
        depends_on:
        - influxdb
        volumes:
        # Mount for telegraf config
        - ./telegraf.conf:/etc/telegraf/telegraf.conf:ro
        #- ./rocm/bin/rocm-smi:/opt/rocm/bin/rocm-smi
        env_file:
        - influxv2.env
```

# Resources 

- https://github.com/RadeonOpenCompute/rocm_smi_lib
- https://github.com/influxdata/telegraf/tree/release-1.25/plugins/inputs/amd_rocm_smi