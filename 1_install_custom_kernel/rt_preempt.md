Ubuntu 18.04 RT_PREEMPT


Uncomment `/etc/apt/sources.list` as follows.
```
deb-src http://jp.archive.ubuntu.com/ubuntu/ bionic main restricted
```


Do
```
$ sudo apt update
$ sudo apt upgrade -y
$ reboot
```


Do 
```
$ sudo apt install kernel-package -y     # select local version wo hoji
$ sudo apt install git ccache fakeroot libncurses5-dev -y
$ sudo apt build-dep linux -y
$ cd /usr/src/
$ sudo wget https://www.kernel.org/pub/linux/kernel/v5.x/linux-5.4.209.tar.xz
$ sudo xz -cd linux-5.4.209.tar.xz | sudo tar xvf -
$ sudo wget https://www.kernel.org/pub/linux/kernel/projects/rt/5.4/older/patch-5.4.209-rt77.patch.xz
$ cd linux-5.4.209/
$ sudo xzcat ../patch-5.4.209-rt77.patch.xz | sudo patch -p1
```


Do
```
$ sudo make menuconfig
```
to configure as follows.

```
# Enable CONFIG_PREEMPT_RT
 -> General Setup
  -> Preemption Model (Fully Preemptible Kernel (Real-Time))
   (X) Fully Preemptible Kernel (Real-Time)

# Enable CONFIG_HIGH_RES_TIMERS
 -> General setup
  -> Timers subsystem
   [*] High Resolution Timer Support

# Enable CONFIG_NO_HZ_FULL
 -> General setup
  -> Timers subsystem
   -> Timer tick handling (Full dynticks system (tickless))
    (X) Full dynticks system (tickless)

# Set CONFIG_HZ_1000 (note: this is no longer in the General Setup menu, go back twice)
 -> Processor type and features
  -> Timer frequency (1000 HZ)
   (X) 1000 HZ
```


Edit `.config` as follows.
```
CONFIG_SYSTEM_TRUSTED_KEYS=""
```


Do
```
$ sudo apt-get install liblz4-tool       # for error of debian/ruleset/targets/common.mk:295: recipe for target 'debian/stamp/build/kernel' failed
$ sudo apt install dwarves               # for error of BTF: .tmp_vmlinux.btf: pahole (pahole) is not available
$ sudo make-kpkg -j 16 --rootcmd fakeroot --initrd --append_to_version=-codelibs --revision=001 kernel_image kernel_headers
$ cd ..
$ sudo dpkg -i linux-headers-5.4.209-codelibs-rt77_001_amd64.deb linux-image-5.4.209-codelibs-rt77_001_amd64.deb
```

# Ref
* https://docs.ros.org/en/foxy/Tutorials/Miscellaneous/Building-Realtime-rt_preempt-kernel-for-ROS-2.html
