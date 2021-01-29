#!bin/bash
printenv | sed 's/^\(.*\)$/export \1/g' | grep -E "AUTOSYNC|AWS" > /root/start.sh
cat aws-sync.sh >> /root/start.sh
echo "" >> /root/start.sh
chmod +x /root/start.sh
touch /var/log/cron.log
/root/start.sh >> /var/log/cron.log
cron && tail -f /var/log/cron.log