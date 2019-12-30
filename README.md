# hub.docker.com/tiredofit/tinc

# Introduction

Dockerfile to build a [tinc](https://www.tinc.org/) container image.

* Latest Release automatically downloaded and compiled (1.1 test series)
* Automatically downloads peer configuration files from git server based on network name.
* Configurable Options for resyncing information from git server
* Configurable Options to enable various types of compression or enable debugging for troubleshooting.
* Logrotate Installed and will rotate logs daily and hold for 7 days.

** Do NOT use a public git server to host your repository, as it will reveal personal details of your network! You have been warned **

This Container uses Alpine:Edge as a base.

[Changelog](CHANGELOG.md)

# Authors

- [Dave Conroy](https://github.com/tiredofit)

# Table of Contents

- [Introduction](#introduction)
    - [Changelog](CHANGELOG.md)
- [Prerequisites](#prerequisites)
- [Installation](#installation)
- [Quick Start](#quick-start)
- [Configuration](#configuration)
    - [Data Volumes](#data-volumes)
    - [Environment Variables](#environmentvariables)   
    - [Networking](#networking)
- [Maintenance](#maintenance)
    - [Shell Access](#shell-access)
   - [References](#references)

# Prerequisites

This image relies on a private Git Repository to store configuration data. Create a private repo and user account in git before proceeding.


# Installation

Automated builds of the image are available on [Docker Hub](https://hub.docker.com/tiredofit/tinc) and is the recommended method of installation.


```bash
docker pull tiredofit/tinc
```

# Quick Start

* The quickest way to get started is using [docker-compose](https://docs.docker.com/compose/). See the examples folder for a working [docker-compose.yml](examples/docker-compose.yml) that can be modified for development or production use.

* Set various [environment variables](#environment-variables) to understand the capabilities of this image.
* Map [persistent storage](#data-volumes) for access to configuration and data files for backup.
* Alter Firewall Configuration to allow access to [network ports](#networking)

# Configuration

### Data-Volumes

The following directories are used for configuration and can be mapped for persistent storage.

| Directory | Description |
|-----------|-------------|
| `/etc/tinc/` | Root tinc Directory |



### Environment Variables

Along with the Environment Variables from the [Base image](https://hub.docker.com/r/tiredofit/alpine), below is the complete list of available options that can be used to customize your installation.

| Parameter | Description |
|-----------|-------------|
| `GIT_URL` | GIT Repository URL (ie `https://github.com/username/repo`)
| `GIT_USER` | Username to Authenticate to git server (e.g. `username`) |
| `GIT_PASS` | Password for above user (e.g. `password`) |
| `CRON_PERIOD` | Adjustable time to check GIT Server for any updates (Default: `5`) |
| `DEBUG` | Adjustable Debug level as per tinc documentation (e.g 5 Deault: `0`) |
| `NETWORK` | The VPN name -  (e.g. `securenetwork`) |
| `NODE` | The unique hostname of the machine joining the VPN (e.g. `hostname`) |
| `PUBLIC_IP` | The public IP you wish to listen on (e.g. `137.233.212.121`) |
| `PRIVATE_IP` | The private IP that is assigned to this machine on the VPN (e.g. `172.16.23.13`) |
| `INTERFACE` | Which Interface to use (relies on /dev/tun) (e.g. `tun0`) |
| `PEERS` | Which server should be used to contact first to create the mesh VPN (e.g. `host1.hostname.com` `host2.hostname.com`) |
| `COMPRESSION` | Level of LZO Compression (e.g. 9) (Default: `1`) |


### Networking

The following ports are exposed.

| Port      | Description |
|-----------|-------------|
| `655` | Tinc |

> **NOTE**: You must also allow capabilities for `NET_ADMIN` to docker to be able to have access to the IP Stack. Also, you must create `/dev/tun` as a device. If you want to make the Docker Host be able to be accessible you also must add `network:host` as an option otherwise only the containers will be accessible. See the working docker-compose.yml example as shown above.


# Maintenance
#### Shell Access

For debugging and maintenance purposes you may want access the containers shell. 

```bash
docker exec -it (whatever your container name is e.g. tinc) bash
```

# References

* https://www.tinc-vpn.org


