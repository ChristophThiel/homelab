#!/bin/bash

echo "Copy docker volumes onto ZFS pool"
rsync -rh --archive --delete --stats /var/lib/docker/volumes /storage/docker --exclude=metadata.db

echo "Copy letsencrypt files onto ZFS pool"
rsync -rh --archive --delete --stats /etc/letsencrypt /storage