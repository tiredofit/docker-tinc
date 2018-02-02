#!/usr/bin/with-contenv bash

### Adjust Runtime Variables for Crontab
	sed -i -e "s/<NETWORK>/$NETWORK/g" /assets/cron/crontab.txt
    sed -i -e "s/<CRON_PERIOD>/$CRON_PERIOD/g" /assets/cron/crontab.txt