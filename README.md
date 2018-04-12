# How to use #
1. download VirtualBox min version 5.2.6
2. download current "VirtualBox Extenstion Pack" min version 5.2.6 (https://www.macworld.co.uk/download/system-desktop-tools/virtualbox-extension-pack-526-3249099/#downloadInfo)
3. create a VirtualBox MacOs image (http://tobiwashere.de/2017/10/virtualbox-how-to-create-a-macos-high-sierra-vm-to-run-on-a-mac-host-system/)
4. activate remote connection on guest system
5. start the vm manually and excute: `ssh-copy-id -p 3022 USERNAME@localhost`
6. activate nopasswd sudo on guest
      1. sudo visudo
	    2. change this line from: `%admin ALL=(ALL) ALL` to:    ``%admin ALL=(ALL) NOPASSWD: ALL`
7. change the variable for your vm
8. for automation use sample crontab
