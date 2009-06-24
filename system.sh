rouse - usalug.org 09-12-2007 
clear
num_cpus=`cat /proc/cpuinfo | grep -c "model name"`
machine_cpu=`cat /proc/cpuinfo | grep -m 1 "model name" | cut -d: -f2`
machine_mhz=`cat /proc/cpuinfo | grep -m 1 "cpu MHz" | cut -d: -f2`
machine_cpuinfo=`uname -mp`
todays_date=`date +"%D %r"`
machine_uptime=`uptime`
machine_ram=`cat /proc/meminfo | grep -m 1 "MemTotal:" | cut -d: -f2 |  sed 's/^[ \t]*//'`
machine_video=`lspci | grep -m 1 "VGA" | cut -d: -f3 |  sed 's/^[ \t]*//'`
machine_eth_card=`lspci | grep -m 1 "Ethernet" | cut -d: -f3 |  sed 's/^[ \t]*//'`
machine_audio_controller=`lspci | grep -m 1 "audio" | cut -d: -f3 |  sed 's/^[ \t]*//'`
arch_damons=`grep "DAEMONS=" /etc/rc.conf `
last_logins=`last | head`
eth0info=`ifconfig eth0 | grep "inet addr:" | sed 's/inet addr/Local IP/g' | sed 's/^[ \t]*//;s/[ \t]*$//'`

echo "ARCH LINUX - Machine Information Script ver .10"
echo "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
echo "DATE: $todays_date   MACHINE NAME: $HOSTNAME  "
echo " "
echo "Eth0: $eth0info"
echo "ETHERNET CARD: $machine_eth_card"
echo "CPU INFO: Qty=$num_cpus $machine_cpuinfo"
echo "VIDEO CARD: $machine_video"
echo "AUDIO CONTROLLER: $machine_audio_controller"
echo "RAM INFO: $machine_ram" 
echo " "
echo "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
route
echo "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
echo "DISK USAGE:"
df -h
echo "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
echo "UPTIME: $machine_uptime"
echo "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
# echo "LAST LOGINS:"; echo $last_logins
# echo "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
echo "$arch_damons"
echo "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
exit 0
