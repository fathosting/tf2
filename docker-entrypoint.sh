#!/bin/bash

home_dir=/home/steam/tf2
backup_vol=/home/steam/backup

exec_extra_params=${EXEC_EXTRA_PARAMS:-"+sv_pure 1 +randommap +maxplayers 24"}

# docker volumes are mounted as root
# chown them to the correct user after mount
chown steam:steam ${backup_vol}

if [ "$(ls -A ${backup_vol})" ]; then
    echo ">> Restoring backup data from volume..."
    # sync backup volume -> container
    rsync -aP ${backup_vol}/ ${home_dir}/tf
fi

# launch lsyncd to sync container -> backup volume
lsyncd /etc/lsyncd/lsyncd.conf.lua

cd ${home_dir}

echo ">> Starting Team Fortress 2 server..."
# execute srcds_run as correct user
exec gosu steam "$@ ${exec_extra_params}"
