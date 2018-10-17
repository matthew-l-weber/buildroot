#!/bin/bash

if [ "$1" == "stop" ]; then
       echo "Stopping qemu..."
       if [ -f qemu.pid ]; then
               kill -9 $(cat qemu.pid)
               rm qemu.pid
               echo " Stopped"
       else
               echo " No session"
       fi
       exit 0
else
       [ -d "output" ] && OUT_DIR_PREFIX=output/
       echo $$ > qemu.pid; exec qemu-system-aarch64 \
               -M virt \
               -cpu cortex-a57 \
               -nographic \
               -smp 1 \
               -kernel ${OUT_DIR_PREFIX}images/Image \
               -append "root=/dev/vda console=ttyAMA0" \
               -netdev user,id=eth0 \
               -device virtio-net-device,netdev=eth0 \
               -drive file=${OUT_DIR_PREFIX}images/rootfs.ext2,if=none,format=raw,id=hd0 \
               -device virtio-blk-device,drive=hd0
       rm qemu.pid
fi
