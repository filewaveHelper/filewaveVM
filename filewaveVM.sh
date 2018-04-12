#!/bin/bash


#####################################################################################################################################################################################
# 1. download VirtualBox min version 5.2.6                                                                                                                                          #
# 2. download current "VirtualBox Extenstion Pack" min version 5.2.6 (https://www.macworld.co.uk/download/system-desktop-tools/virtualbox-extension-pack-526-3249099/#downloadInfo) #
# 3. create a VirtualBox MacOs image (http://tobiwashere.de/2017/10/virtualbox-how-to-create-a-macos-high-sierra-vm-to-run-on-a-mac-host-system/)                                   #
# 4. activate remote connection on guest system                                                                                                                                     #
# 5. start the vm manually and excute: `ssh-copy-id -p 3022 USERNAME@localhost`                                                                                                     #
# 6. activate nopasswd sudo on guest                                                                                                                                                #
#       1. sudo visudo                                                                                                                                                              #
# 	    2. change this line from: `%admin ALL=(ALL) ALL` to:    ``%admin ALL=(ALL) NOPASSWD: ALL`                                                                                   #
# 7. change the variable for your vm                                                                                                                                                #
# 8. for automation use sample crontab                                                                                                                                              #
#####################################################################################################################################################################################


## variables

vm="NAME_OF_VM"
username="USER_NAME"
serialNumber="SERIAL_NUMBER"

copyLogs="true"
logfolder="/Users/XXX/private/filewave/logs/filewave"

VBoxManage="/usr/local/bin/VBoxManage"

## variables end

# script
mypid=$$

for pid in `ps -ef | grep filewaveVM.sh | awk '{print $2}'` ; do 
if [ "$mypid" != "$pid" ]; then
kill -9 $pid >/dev/null 2>&1 ;
fi 
done

$VBoxManage controlvm $vm poweroff soft >/dev/null 2>&1

$VBoxManage modifyvm $vm --cpuidset 00000001 000106e5 00100800 0098e3fd bfebfbff
$VBoxManage modifyvm  $vm --natpf1 "ssh,tcp,,3022,,22" >/dev/null 2>&1
$VBoxManage setextradata $vm "VBoxInternal/Devices/efi/0/Config/DmiSystemProduct" "MacBook Pro (Retina, 15', Mitte 2015)"
$VBoxManage setextradata $vm "VBoxInternal/Devices/efi/0/Config/DmiBoardProduct" "Mac-F2238BAE"
$VBoxManage setextradata $vm "VBoxInternal/Devices/smc/0/Config/DeviceKey" "ourhardworkbythesewordsguardedpleasedontsteal(c)AppleComputerInc"
$VBoxManage setextradata $vm "VBoxInternal/Devices/smc/0/Config/GetKeyFromRealSMC" 1
$VBoxManage setextradata $vm "VBoxInternal2/EfiGopMode" 5
$VBoxManage setextradata $vm "VBoxInternal/Devices/efi/0/Config/DmiSystemSerial" "W8#######1A"
$VBoxManage setextradata $vm "VBoxInternal/Devices/efi/0/Config/DmiBoardSerial" "W8#########1A"
$VBoxManage setextradata $vm "VBoxInternal/Devices/efi/0/Config/DmiSystemVendor" "Apple Inc."
$VBoxManage setextradata $vm "VBoxInternal/Devices/efi/0/Config/DmiSystemFamily" "MacBook Pro"
$VBoxManage setextradata $vm "VBoxInternal/Devices/efi/0/Config/DmiBIOSVersion" "IM112.0057.03B"
$VBoxManage modifyvm $vm --cpu-profile "Intel Core i7-3960X"
$VBoxManage setextradata $vm VBoxInternal/Devices/efi/0/Config/DmiSystemSerial $serialNumber

while [ 1 -lt 4 ]
do
echo "$(date) VM started"
$VBoxManage startvm $vm --type headless
sleep 600

if [ "$copyLogs" == "true" ]; then
scp -P 3022 $username@localhost:/private/var/log/fwcld.log $logfolder >/dev/null 2>&1
mv $logfolder/fwcld.log $logfolder/filewave_backup_$(date '+%Y-%m-%d_%H-%M-%S' ).log >/dev/null 2>&1
ssh -p 3022 -t $username@localhost "sudo rm -rf /private/var/log/fwcld.log"  >/dev/null 2>&1 ;
ssh -p 3022 -t $username@localhost "sudo rm -rf /private/var/log/fwcld.log"  >/dev/null 2>&1 ;
ssh -p 3022 -t $username@localhost "sudo rm -rf /private/var/log/fwcld.log"  >/dev/null 2>&1 ;
fi 

$VBoxManage controlvm $vm poweroff soft

echo "$(date) VM stopped"
sleep $[(RANDOM%60+45)*60]
done


