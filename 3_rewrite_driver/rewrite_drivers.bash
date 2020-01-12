#!/bin/bash 

# copy
sudo cp makefile/Makefileamd64.dpg0100 /usr/src/interface/common/dpg0100/src
sudo cp patchfile/dpg0100.patch /usr/src/interface/common/dpg0100/src

sudo cp makefile/Makefileamd64.dpg0101 /usr/src/interface/common/dpg0101/src
sudo cp patchfile/dpg0101.patch /usr/src/interface/common/dpg0101/src

sudo cp makefile/Makefileamd64.gpg3100 /usr/src/interface/gpg3100/x86_64/linux/drivers/src
sudo cp patchfile/ad_entry.patch /usr/src/interface/gpg3100/x86_64/linux/drivers/src

sudo cp makefile/Makefileamd64.gpg3300 /usr/src/interface/gpg3300/x86_64/linux/drivers/src
sudo cp patchfile/da_drventry.patch /usr/src/interface/gpg3300/x86_64/linux/drivers/src

sudo cp makefile/Makefileamd64.gpg6204 /usr/src/interface/gpg6204/x86_64/linux/drivers/src
sudo cp patchfile/penc_drventry.patch /usr/src/interface/gpg6204/x86_64/linux/drivers/src

sudo cp patchfile/ld_so_conf.patch /etc


# dpg0100
cd /usr/src/interface/common/dpg0100/src
sudo mv Makefile Makefile.dist
sudo mv Makefileamd64.dpg0100 Makefile
sudo cp dpg0100.c dpg0100.bak
sudo patch -b -i dpg0100.patch
sudo make
sudo make install


# dpg0101
cd /usr/src/interface/common/dpg0101/src
sudo mv Makefile Makefile.dist
sudo mv Makefileamd64.dpg0101 Makefile
sudo cp dpg0101.c dpg0101.bak
sudo patch -b -i dpg0101.patch
sudo make
sudo make install


# gpg3100
cd /usr/src/interface/gpg3100/x86_64/linux/drivers/src/
sudo mv Makefile Makefile.dist
sudo mv Makefileamd64.gpg3100 Makefile
sudo cp ad_entry.c ad_entry.bak
sudo ln -s /usr/include/dpg0100.h .
sudo patch -b -i ad_entry.patch
sudo ln -s /usr/src/interface/gpg3100/x86_64/linux/drivers/ver26/bocp3100noreg.o .
sudo make
sudo rm Module.symvers
sudo cp /usr/src/interface/common/dpg0100/src/Module.symvers .
sudo make
sudo make install


# gpg3300
cd /usr/src/interface/gpg3300/x86_64/linux/drivers/src/
sudo mv Makefile Makefile.dist
sudo mv Makefileamd64.gpg3300 Makefile
sudo cp da_drventry.c da_drventry.bak
sudo ln -s /usr/include/fbida.h .
sudo patch -b -i da_drventry.patch
sudo ln -s /usr/src/interface/gpg3300/x86_64/linux/drivers/ver26/bocp3300noreg.o .
sudo make
sudo make install


# gpg6204
cd /usr/src/interface/gpg6204/x86_64/linux/drivers/src/
sudo mv Makefile Makefile.dist
sudo mv Makefileamd64.gpg6204 Makefile
sudo cp penc_drventry.c penc_drventry.bak
sudo ln -s /usr/include/dpg0100.h .
sudo ln -s /usr/include/fbipenc.h .
sudo patch -b -i penc_drventry.patch
sudo ln -s /usr/src/interface/gpg6204/x86_64/linux/drivers/ver26/bocp6204noreg.o .
sudo make
sudo rm Module.symvers
sudo cp /usr/src/interface/common/dpg0100/src/Module.symvers .
sudo make
sudo make install


# ld_so_conf
cd /etc
sudo cp ld.so.conf ld.so.conf.bak
sudo patch -b -i ld_so_conf.patch
sudo ldconfig


# depmod
cd /
sudo depmod -A
sudo depmod -a
