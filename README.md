# github.com/tiredofit/docker-tinc

[![GitHub release](https://img.shields.io/github/v/tag/tiredofit/docker-tinc?style=flat-square)](https://github.com/tiredofit/docker-tinc/releases/latest)
[![Build Status](https://img.shields.io/github/workflow/status/tiredofit/docker-tinc/build?style=flat-square)](https://github.com/tiredofit/docker-tinc/actions?query=workflow%3Abuild)
[![Docker Stars](https://img.shields.io/docker/stars/tiredofit/tinc.svg?style=flat-square&logo=docker)](https://hub.docker.com/r/tiredofit/tinc/)
[![Docker Pulls](https://img.shields.io/docker/pulls/tiredofit/tinc.svg?style=flat-square&logo=docker)](https://hub.docker.com/r/tiredofit/tinc/)
[![Become a sponsor](https://img.shields.io/badge/sponsor-tiredofit-181717.svg?logo=github&style=flat-square)](https://github.com/sponsors/tiredofit)
[![Paypal Donate](https://img.shields.io/badge/donate-paypal-00457c.svg?logo=paypal&style=flat-square)](https://www.paypal.me/tiredofit)
* * *

## About

This will build a Docker Image for [tinc](https://www.tinc.org/) - A VPN service.

* Latest Release automatically downloaded and compiled (1.1 test series)
* Automatically downloads peer configuration files from git server based on network name.
* Configurable Options for resyncing information from git server
* Configurable Options to enable various types of compression or enable debugging for troubleshooting.
* Logrotate Installed and will rotate logs daily and hold for 7 days.

**Do NOT use a public git server to host your repository, as it will reveal personal details of your network! You have been warned**

## Maintainer

- [Dave Conroy](https://github.com/tiredofit)

## Table of Contents

- [About](#about)
- [Maintainer](#maintainer)
- [Table of Contents](#table-of-contents)
- [Prerequisites and Assumptions](#prerequisites-and-assumptions)
- [Installation](#installation)
  - [Build from Source](#build-from-source)
  - [Prebuilt Images](#prebuilt-images)
    - [Multi Architecture](#multi-archictecture)
- [Configuration](#configuration)
  - [Quick Start](#quick-start)
  - [Persistent Storage](#persistent-storage)
  - [Environment Variables](#environment-variables)
    - [Base Images used](#base-images-used)
  - [Networking](#networking)
- [Maintenance](#maintenance)
  - [Shell Access](#shell-access)
- [Support](#support)
  - [Usage](#usage)
  - [Bugfixes](#bugfixes)
  - [Feature Requests](#feature-requests)
  - [Updates](#updates)
- [License](#license)
- [References](#references)

## Prerequisites and Assumptions

* This image relies on a private Git Repository to store configuration data. Create a private repo and user account in git before proceeding.

## Installation

### Build from Source
Clone this repository and build the image with `docker build <arguments> (imagename) .`

### Prebuilt Images
Builds of the image are available on [Docker Hub](https://hub.docker.com/r/tiredofit/tinc) and is the recommended method of installation.

The following image tags are available along with their tagged release based on what's written in the [Changelog](CHANGELOG.md):

| Container OS | Tag       |
| ------------ | --------- |
| Alpine       | `:latest` |

#### Multi Architecture
Images are built primarily for `amd64` architecture, and may also include builds for `arm/v7`, `arm64` and others. These variants are all unsupported. Consider [sponsoring](https://github.com/sponsors/tiredofit) my work so that I can work with various hardware. To see if this image supports multiple architecures, type `docker manifest (image):(tag)`

## Configuration

### Quick Start

* The quickest way to get started is using [docker-compose](https://docs.docker.com/compose/). See the examples folder for a working [docker-compose.yml](examples/docker-compose.yml) that can be modified for development or production use.

* Set various [environment variables](#environment-variables) to understand the capabilities of this image.
* Map [persistent storage](#data-volumes) for access to configuration and data files for backup.
* Alter Firewall Configuration to allow access to [network ports](#networking)

### Persistent Storage

The following directories are used for configuration and can be mapped for persistent storage.

| Directory       | Description         |
| --------------- | ------------------- |
| `/etc/tinc/`    | Root tinc Directory |
| `/var/log/tinc` | Log Files           |

### Environment Variables

#### Base Images used

This image relies on an [Alpine Linux](https://hub.docker.com/r/tiredofit/alpine) base image that relies on an [init system](https://github.com/just-containers/s6-overlay) for added capabilities. Outgoing SMTP capabilities are handlded via `msmtp`. Individual container performance monitoring is performed by [zabbix-agent](https://zabbix.org). Additional tools include: `bash`,`curl`,`less`,`logrotate`, `nano`,`vim`.

Be sure to view the following repositories to understand all the customizable options:

| Image                                                  | Description                            |
| ------------------------------------------------------ | -------------------------------------- |
| [OS Base](https://github.com/tiredofit/docker-alpine/) | Customized Image based on Alpine Linux |

| Parameter              | Description                                                                                                          | Default         |
| ---------------------- | -------------------------------------------------------------------------------------------------------------------- | --------------- |
| `CIPHER`               | Encryption Cipher                                                                                                    | `aes-256-cbc`   |
| `COMPRESSION`          | Level of LZO Compression (e.g. 9)                                                                                    | `0`             |
| `CRON_PERIOD`          | Adjustable time to check GIT Server for any updates                                                                  | `30`            |
| `DEBUG`                | Adjustable Debug level as per tinc documentation (e.g 5)                                                             | `0`             |
| `DIGEST`               | Hashing Digest                                                                                                       | `sha256`        |
| `ENABLE_GIT`           | Enable Git Repository Functionality `TRUE` or `FALSE`                                                                | `TRUE`          |
| `ENABLE_CONFIG_RELOAD` | Enable reloading Tinc when configuration changes                                                                     | `TRUE`          |
| `ENABLE_WATCHDOG`      | Reload Tinc when it can't get a response from a host                                                                 | `FALSE`         |
| `GIT_PASS`             | Password for above user (e.g. `password`)                                                                            |                 |
| `GIT_URL`              | GIT Repository URL (ie `https://github.com/username/repo.git`)                                                       |                 |
| `GIT_USER`             | Username to Authenticate to git server (e.g. `username`)                                                             |                 |
| `INTERFACE`            | Which Interface to use (relies on /dev/tun) (e.g. `tun0`)                                                            | `tun0`          |
| `LISTEN_PORT`          | Listening Port                                                                                                       | `655`           |
| `LOG_PATH`             | Log Path                                                                                                             | `/var/log/tinc` |
| `MAC_LENGTH`           | MAC Length                                                                                                           | `16`            |
| `NETWORK`              | The VPN name -  (e.g. `securenetwork`)                                                                               |                 |
| `NODE`                 | The unique hostname of the machine joining the VPN (e.g. `hostname`)                                                 |                 |
| `PEERS`                | Which server should be used to contact first to create the mesh VPN (e.g. `host1_hostname_com` `host2_hostname_com`) |                 |
| `PRIVATE_IP`           | The private IP that is assigned to this machine on the VPN (e.g. `172.16.23.13`)                                     |                 |
| `PUBLIC_IP`            | The public IP you wish to listen on (e.g. `137.233.212.121`)                                                         |                 |
| `SETUP_TYPE`           | Utilize these above environment variables `AUTO` or `MANUAL`                                                         | `AUTO`          |
| `WATCHDOG_HOST`        | IP Address or hostname of host to check connectivity                                                                 |                 |
| `WATCHDOG_FREQUENCY`   | How many seconds to wait between checks on host                                                                      | `60`            |

### Networking

The following ports are exposed.

| Port  | Description |
| ----- | ----------- |
| `655` | Tinc        |

> **NOTE**: You must also allow capabilities for `NET_ADMIN` to docker to be able to have access to the IP Stack. Also, you must create `/dev/tun` as a device. If you want to make the Docker Host be able to be accessible you also must add `network:host` as an option otherwise only the containers will be accessible. See the working docker-compose.yml example as shown above.

* * *
## Maintenance

### Shell Access

For debugging and maintenance purposes you may want access the containers shell.

``bash
docker exec -it (whatever your container name is) bash
``

## Support

These images were built to serve a specific need in a production environment and gradually have had more functionality added based on requests from the community.
### Usage
- The [Discussions board](../../discussions) is a great place for working with the community on tips and tricks of using this image.
- Consider [sponsoring me](https://github.com/sponsors/tiredofit) personalized support.
### Bugfixes
- Please, submit a [Bug Report](issues/new) if something isn't working as expected. I'll do my best to issue a fix in short order.

### Feature Requests
- Feel free to submit a feature request, however there is no guarantee that it will be added, or at what timeline.
- Consider [sponsoring me](https://github.com/sponsors/tiredofit) regarding development of features.

### Updates
- Best effort to track upstream changes, More priority if I am actively using the image in a production environment.
- Consider [sponsoring me](https://github.com/sponsors/tiredofit) for up to date releases.

## License
MIT. See [LICENSE](LICENSE) for more details.
## References

* https://www.tinc-vpn.org
