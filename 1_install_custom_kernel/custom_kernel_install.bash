#!/bin/bash 


sudo rm /var/lib/apt/lists/lock
sudo rm /var/lib/dpkg/lock
sudo apt-get install make -y
sudo apt-get install gcc -y
sudo apt-get install libncurses5-dev -y
sudo apt-get install kernel-package -y 
sudo apt-get install bzip2 -y
sudo apt-get install bin86 -y 
sudo apt-get install flex -y
sudo apt-get install bison -y
sudo apt install libssl-dev -y

# get kernel source
cd /usr/src/
#sudo wget https://www.kernel.org/pub/linux/kernel/v5.x/linux-5.2.14.tar.xz
#sudo xz -cd linux-5.2.14.tar.xz | sudo tar xvf -
sudo wget https://www.kernel.org/pub/linux/kernel/v5.x/linux-5.0.14.tar.xz
sudo xz -cd linux-5.0.14.tar.xz | sudo tar xvf -

# RT-preempt patch
#sudo wget https://www.kernel.org/pub/linux/kernel/projects/rt/5.2/older/patch-5.2.14-rt7.patch.xz
#cd linux-5.2.14/
#sudo xzcat ../patch-5.2.14-rt7.patch.xz | sudo patch -p1
sudo wget https://www.kernel.org/pub/linux/kernel/projects/rt/5.0/older/patch-5.0.14-rt8.patch.xz
cd linux-5.0.14/
sudo xzcat ../patch-5.0.14-rt8.patch.xz | sudo patch -p1

# configure, compile, and install
sudo make menuconfig
sudo make -j4
sudo make modules_install
sudo make install
