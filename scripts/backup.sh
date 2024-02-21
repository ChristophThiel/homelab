#!/bin/bash
echo "Start"

echo "Backup snapshot to local backup"
export RESTIC_PASSWORD_FILE=$LOCAL_RESTIC_PASSWORD_FILE
restic -r /backup --verbose backup /storage

echo "Forget and prune older snapshots for local backup"
restic -r /backup forget --prune --keep-daily 7 --keep-weekly=4 --keep-monthly=3

echo "Print stats for local backup"
restic -r /backup stats latest

echo "Copy snapshot to cloud backup"
export RESTIC_PASSWORD_FILE=$OFFSITE_RESTIC_PASSWORD_FILE
export RESTIC_FROM_PASSWORD_FILE=$LOCAL_RESTIC_PASSWORD_FILE
restic -r <enter-bucket-url> copy --from-repo /backup

echo "Forget and prune older snapshot for cloud backup"
restic -r <ener-bucket-url> forget --prune --keep-daily 30

echo "Send drives into spin down and change idle timeout"
/sbin/hdparm -q -S 180 -y /dev/disk/by-id/ata-WDC_WD40EFPX-68C6CN0_WD-WX22A82EZKSH /dev/disk/by-id/ata-WDC_WD40EFPX-68C6CN0_WD-WXK2D23NDF9A

echo "Done"