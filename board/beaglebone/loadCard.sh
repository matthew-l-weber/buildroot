#! /bin/sh
myPWD=`pwd`
DRIVE=$1
umount ${DRIVE}*
sleep 1

mkdir /mnt/sdcard1
#mkdir /mnt/sdcard2

mount ${DRIVE}1 /mnt/sdcard1
#mount ${DRIVE}2 /mnt/sdcard2
cp MLO                   /mnt/sdcard1
cp u-boot.img            /mnt/sdcard1
cp zImage                /mnt/sdcard1
cp am335x-boneblack.dtb  /mnt/sdcard1
cp uEnv.txt              /mnt/sdcard1
#cd /mnt/sdcard2
#echo "dir is ${myPWD}"
dd if=${myPWD}/rootfs.ext2 of=${DRIVE}2
#tar zxvaf ${myPWD}/test-rootfs.tar.gz
#cd -
umount ${DRIVE}1 ${DRIVE}2
sync
