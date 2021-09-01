#!/bin/sh
PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin
SERVER_NAME=docker1
TIMESTAMP=$(date +"%F")
BACKUP_DIR="/home/backup/$TIMESTAMP"
APP_DIR="/home/nextcloud"
SCRIPT_BK_NEXTCLOUD=/usr/bin/backup-nextcloud.sh

# Install rclone
if [ -f /usr/sbin/rclone]; then
    echo "rclone da ton tai"
else
    yum -y install wget unzip
    cd /root/
    wget https://downloads.rclone.org/rclone-current-linux-amd64.zip
    unzip rclone-current-linux-amd64.zip
    cp rclone-v*-linux-amd64/rclone /usr/sbin/
    rm -rf rclone-*
fi

# Make folder for app
if [ -d "$BACKUP_DIR/nextcloud" ]; then
    echo" thu muc da ton tai"
else
    mkdir -p "$BACKUP_DIR/nextcloud"
fi

# Backup
cd "$BACKUP_DIR/nextcloud"
tar -czf backup-$(date +%F\-%H\-%M\-%S).tar.gz "$APP_DIR" >/dev/null 2>&1

# Keep the last 3 backups
# find "$BACKUP_DIR/nextcloud" -type f -name "*.gz" -cmin +3 -delete
find "$BACKUP_DIR" -type f -name "*.gz" -mtime +3 -delete

# Clean up local disk , folder TIMESTAMP
find "/home/backup" -type d -name "*" -mtime +3 delete

# Backup on Google Drive
#echo "Starting Uploading Backup"
#/usr/sbin/rclone move $BACKUP_DIR "remote:$SERVER_NAME/$TIMESTAMP" >> /var/log/rclone.log 2>&1

# Clean up Google Drive

# cron
if [ -f /etc/cron.d/nextcloud.cron ]; then
    echo "exist file"
else
    cat > "/etc/cron.d/nextcloud.cron" <<EOF
    SHELL=/bin/sh
    * * * * * root $SCRIPT_BK_NEXTCLOUD >/dev/null 2>&1
    systemctl restart crond.service
EOF
fi