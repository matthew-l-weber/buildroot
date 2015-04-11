#! /bin/sh
myPWD=$(pwd)
DRIVE=$1

fail()
{
   echo "FAILED: $1"
   exit 0
}


[ ! -e "${DRIVE}" ] && fail "${DRIVE} does not exist"
[ ! -e "${DRIVE}1" ] && fail "${DRIVE} does not have partition #1"
[ ! -e "${DRIVE}2" ] && fail "${DRIVE} does not have partition #2"
umount ${DRIVE}*
sleep 0.5

# Cleanup mounts.....
[ -d "/mnt/sdcard1" ] && umount /mnt/sdcard1
[ -d "/mnt/sdcard2" ] && umount /mnt/sdcard2
sleep 0.5
[ -d "/mnt/sdcard1" ] && rm -fr /mnt/sdcard1
[ -d "/mnt/sdcard2" ] && rm -fr /mnt/sdcard2
mkdir /mnt/sdcard1
mkdir /mnt/sdcard2

mount ${DRIVE}1 /mnt/sdcard1
cp MLO                   /mnt/sdcard1
cp u-boot.img            /mnt/sdcard1
[ -e "/mnt/sdcard1/zImage" ] && rm -f zImage /mnt/sdcard1
rsync -lptD   uImage        /mnt/sdcard1/uImage
# set default to v2 config for now
cp am335x-boneblack-comfortStatv2.dtb  /mnt/sdcard1/am335x-boneblack.dtb
cp am335x-boneblack-comfortStatv1.dtb  /mnt/sdcard1
cp am335x-boneblack-comfortStatv2.dtb  /mnt/sdcard1
cp uEnv.txt              /mnt/sdcard1
sync
umount ${DRIVE}1
[ -d "/mnt/sdcard1" ] && rm -fr /mnt/sdcard1

mount ${DRIVE}2 /mnt/sdcard2
[ -d "${myPWD}/tmp" ] && rm -rf tmp
mkdir tmp
tar xf ${myPWD}/rootfs.tar.bz2 -C ${myPWD}/tmp/
rsync -av --delete-before ${myPWD}/tmp/ /mnt/sdcard2/
rm -rf tmp
#rm rootfs.ext2
#bunzip2 rootfs.ext2.bz2
#dd if=/dev/zero of=${DRIVE}2 bs=1024 count=1024
#dd if=${myPWD}/rootfs.ext2 of=${DRIVE}2
sync
umount ${DRIVE}2
[ -d "/mnt/sdcard2" ] && rm -fr /mnt/sdcard2
