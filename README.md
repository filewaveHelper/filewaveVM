# How to use #
1. download VirtualBox min version 5.2.6
2. download current "VirtualBox Extenstion Pack" min version 5.2.6 (https://www.macworld.co.uk/download/system-desktop-tools/virtualbox-extension-pack-526-3249099/#downloadInfo)
3. create a VirtualBox MacOs image (http://tobiwashere.de/2017/10/virtualbox-how-to-create-a-macos-high-sierra-vm-to-run-on-a-mac-host-system/)
4. activate port-mapping in VirtualBox (network > adapter X > port-mapping) (protocol: "TCP" host-port: "3022" guest-port: "22")\
5. activate remote connection on guest system ("System Preferences" > "Sharing")
6. deactivate password for login and screensaver ("System Preferences" > "Security & Privacy")
7. activate nopasswd sudo on guest system
   1. open terminal on guest system
   2. `sudo visudo`
8. change the variable for your vm in script `filewaveVM.sh`
9. for automation use sample crontab
