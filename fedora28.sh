#!/data/data/com.termux/files/usr/bin/bash
folder=fedora-fs
if [ -d "$folder" ]; then
    first=1
    echo "skipping downloading"
fi
if [ "$first" != 1 ];then
    if [ ! -f "fedora.tar.xz" ]; then
        echo "downloading fedora-docker-image"
        if [ "$(dpkg --print-architecture)" = "aarch64" ];then
            wget https://us.images.linuxcontainers.org/images/fedora/28/arm64/default/20190415_20:33/rootfs.tar.xz -O fedora.tar.xz
        elif [ "$(dpkg --print-architecture)" = "arm" ];then
            wget https://us.images.linuxcontainers.org/images/fedora/28/armhf/default/20190415_20:33/rootfs.tar.xz -O fedora.tar.xz
        elif [ "$(dpkg --print-architecture)" = "x86_64" ];then
            wget https://us.images.linuxcontainers.org/images/fedora/28/amd64/default/20190415_20:33/rootfs.tar.xz -O fedora.tar.xz
        elif [ "$(dpkg --print-architecture)" = "amd64" ];then
            wget https://us.images.linuxcontainers.org/images/fedora/28/amd64/default/20190415_20:33/rootfs.tar.xz -O fedora.tar.xz



        else
            echo "unknown architecture"
            exit 1
        fi
    fi
    cur=`pwd`
    mkdir -p $folder
    mkdir $folder/boot
    mkdir $folder/dev
    mkdir $folder/etc
    mkdir $folder/home
    mkdir $folder/lost+found
    mkdir $folder/mnt
    mkdir $folder/opt
    mkdir $folder/proc
    mkdir $folder/root
    mkdir $folder/run
    mkdir $folder/srv
    mkdir $folder/sys
    mkdir $folder/tmp
    mkdir $folder/usr
    mkdir $folder/var
    mkdir $folder/usr/bin
    mkdir $folder/usr/sbin
    mkdir $folder/usr/lib
    mkdir $folder/usr/lib/pm-utils/
    mkdir $folder/usr/lib/pm-utils/module.d
    mkdir $folder/usr/lib/pm-utils/power.d/
    mkdir $folder/usr/lib/pm-utils/sleep.d/

    echo "decompressing fedora image"
proot --link2symlink tar -C $folder/ -xf $cur/fedora.tar.xz ||:
    echo "fixing nameserver, otherwise it can't connect to the internet"
    cp resolv.conf $folder/etc/
 



fi
mkdir -p fedora-binds
bin=start.sh
echo "writing launch script"
cat > $bin <<- EOM
#!/bin/bash
cd \$(dirname \$0)
## unset LD_PRELOAD in case termux-exec is installed
unset LD_PRELOAD
command="proot"
command+=" --link2symlink"
command+=" -0"
command+=" -r $folder"
if [ -n "\$(ls -A fedora-binds)" ]; then
    for f in fedora-binds/* ;do
      . \$f
    done
fi
command+=" -b /dev"
command+=" -b /proc"
command+=" -b fedora-fs/tmp:/dev/shm"
command+=" -b /data/data/com.termux"
command+=" -b /:host-rootfs"
command+=" -b /sdcard"
command+=" -b /storage"
command+=" -b /mnt"
command+=" -w /root"
command+=" /usr/bin/env -i"
command+=" HOME=/root"
command+=" PATH=/usr/local/sbin:/usr/local/bin:/bin:/usr/bin:/sbin:/usr/sbin:/usr/games:/usr/local/games"
command+=" TERM=\$TERM"
command+=" LANG=C.UTF-8"
command+=" /bin/bash --login"
com="\$@"
if [ -z "\$1" ];then
    exec \$command
else
    \$command -c "\$com"
fi
EOM

echo "fixing shebang of $bin"
termux-fix-shebang $bin
echo "making $bin executable"
chmod +x $bin
echo "removing image for some space"
chmod +w .
rm fedora.tar.xz
bash extra.sh
echo "You can now launch Fedora with the ./start.sh script"

