### Backup Workflow
1. Run script install-dependencies.sh
2. Config rclone manual
   - rclone config
3. Edit script backup for app1.
   - change name app
   - edit password for email postfix.
4. Copy script backup-app1.sh to /usr/bin/  
5. Run script backup.sh
6. If need backup app2, repeat step 3-5.
7. Done!

vi /etc/cron.d/app1.cron
systemctl restart crond
vi /usr/bin/backup-app1.sh
vi 
./backup-app1.sh
systemctl restart crond

tail -f /var/log/maillog 