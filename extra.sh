echo "Fixing some things (it may take several minutes)"
bash ~/fedora-in-termux/start.sh
yum install busybox -y 
cd /sbin/ 
ln -s /sbin/busybox clear  
exit
