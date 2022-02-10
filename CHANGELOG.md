## 3.1.6 2022-02-09 <dave at tiredofit dot ca>

   ### Changed
      - Refresh base image


## 3.1.5 2021-11-24 <dave at tiredofit dot ca>

   ### Added
      - Alpine 3.15 base


## 3.1.4 2021-10-24 <dave at tiredofit dot ca>

   ### Changed
      - Update fluent-bit log details


## 3.1.3 2021-09-04 <dave at tiredofit dot ca>

   ### Changed
      - Change the way that logrotate configuration occurs


## 3.1.2 2021-08-30 <dave at tiredofit dot ca>

   ### Changed
      - Fix logrotate


## 3.1.1 2021-08-30 <dave at tiredofit dot ca>

   ### Added
      - Add fluent-bit log parsing configuration


## 3.1.0 2021-07-03 <dave at tiredofit dot ca>

   ### Added
      - Alpine 3.14 Base
      - Tinc 1.1pre18


## 3.0.1 2021-04-13 <dave at tiredofit dot ca>

   ### Added
      - Timestamp notification for watchdog and Configuration change
   ### Changed
      - Stop reloading Tinc at 23:59 for logrotate

## 3.0.0 2021-04-12 <dave at tiredofit dot ca>

   ### Added
      - Configuration reloading capability if config files change
      - Watchdog functionality to restart Tinc should a host not be accessible
      - Environment variables for LISTEN_PORT, CIPHER, DIGEST, MAC_LENGTH
      - Alpine 3.13 base

## 2.6.0 2020-07-02 <dave at tiredofit dot ca>

   ### Added
      - Allow to function wihtout Git - Set `ENABLE_GIT=FALSE`

   ### Changed
      - Added some debug information when `CONTAINER_LOG_LEVEL=DEBUG`
      - Fixed some scripting issues as per bash shellcheck


## 2.5.0 2020-06-09 <dave at tiredofit dot ca>

   ### Added
      - Update to support tiredofit/alpine 5.0.0 base image


## 2.4.3 2020-01-02 <dave at tiredofit dot ca>

   ### Changed
      - Additional changes to support new tiredofit/alpine base image


## 2.4.2 2018-11-17 <dave at tiredofit dot ca>

* Update Libcrypto to 1.1

## 2.4.1 2018-10-24 <dave at tiredofit dot ca>

* Bump to 1.1pre17

## 2.4 2018-07-15 <dave at tiredofit dot ca>

* Bump to 1.1pre16

## 2.3 2018-01-10 <dave at tiredofit dot ca>

* Version bump to 1.1pre15

## 2.2 2017-09-08 <dave at tiredofit dot ca>

* Minor Cron Fix

## 2.1 2017-08-27 <dave at tiredofit dot ca>

* Minor File Cleanup

## 2.0 2017-07-09 <dave at tiredofit dot ca>

* Rebase with Zabbix, S6, and Logrotate
* Fixed Bad Configuration Options

## 1.0 2017-01-25 <dave at tiredofit dot ca>

* Initial Release
* Alpine Edge Base
* Tinc 1.1.4pre
* Automatically pulls from GIT Repository based on Environment Variables and Updates
* Allows for multiple tunnels to be started on same machine.

