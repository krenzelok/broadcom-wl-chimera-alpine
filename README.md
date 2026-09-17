# broadcom-wl-chimera-alpine
## Automated build and patch script for the Broadcom STA (wl) Wi-Fi driver on Alpine and Chimera Linux
### To run it just
Clone the repo
```bash
git clone https://github.com/krenzelok/broadcom-wl-chimera-alpine.git
```
Change directory
```bash
cd broadcom-wl-chimera-alpine
```
Run it
```bash
./patchwl
```

### Manual installation
First get the required dependencies (Assuming you have linux-stable)
```bash
doas apk add linux-headers linux-stable-devel base-devel git wget
```
If you use alpine 
```bash
doas apk add linux-headers linux-stable-dev build-base git wget
```
Clone the broadcom repo
```bash
git clone https://github.com/joanbm/broadcom-wl-linux-mainline.git
```
Change directory
```bash
cd broadcom-wl-linux-mainline
```
Run the extract and patch script
```bash
./extract_and_patch
```
Go inside the folder it made (My case its hybrid-v35_64-nodebug-pcoem-6_30_223_271)
```bash
cd hybrid-v35_64-nodebug-pcoem-6_30_223_271
```
Compile on chimera
```bash
make -C /lib/modules/$(uname -r)/build M=$(pwd) CC=clang
```
If on alpine
```bash
make -C /lib/modules/$(uname -r)/build M=$(pwd)
```
(Optional) check if the compiled driver is here
```bash
ls -l wl.ko
```
Now make a directory in modules
```bash
doas mkdir -p /lib/modules/$(uname -r)/extra
```
Now copy the newly compiled driver
```bash
doas cp wl.ko /lib/modules/$(uname -r)/extra/
```
Update the driver database
```bash
doas depmod -a
```
(Optional) check if modprobe recognizes it
```bash
modinfo wl
```


