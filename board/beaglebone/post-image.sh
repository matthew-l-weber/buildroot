#!/bin/sh
# post-image.sh for BeagleBone
# 2014, Marcin Jabrzyk <marcin.jabrzyk@gmail.com>

# copy the uEnv.txt to the output/images directory
cp board/beaglebone/uEnv.txt $BINARIES_DIR/uEnv.txt
cp board/beaglebone/mkcard.sh $BINARIES_DIR/
cp board/beaglebone/loadCard.sh $BINARIES_DIR/
chmod 700 $BINARIES_DIR/mkcard.sh $BINARIES_DIR/loadCard.sh
