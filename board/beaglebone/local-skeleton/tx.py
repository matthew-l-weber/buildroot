#https://github.com/doceme/py-spidev

import spidev
import time

Frequency=960

rfm69=spidev.SpiDev()
rfm69.open(1,0)

# { RFM69_REG_01_OPMODE, RF_OPMODE_SEQUENCER_ON | RF_OPMODE_LISTEN_OFF | RFM69_MODE_SLEEP },
rfm69.xfer2([0x80 | 0x01, 0x00 | 0x00 | 0x00])

# { RFM69_REG_02_DATA_MODUL, RF_DATAMODUL_DATAMODE_PACKET | RF_DATAMODUL_MODULATIONTYPE_FSK | RF_DATAMODUL_MODULATIONSHAPING_00 },
rfm69.xfer2([0x80 | 0x02, 0x00 | 0x00 | 0x00])

# { RFM69_REG_03_BITRATE_MSB, 0x3E}, // 2000 bps
rfm69.xfer2([0x80 | 0x03, 0x3E])

# { RFM69_REG_04_BITRATE_LSB, 0x80},
rfm69.xfer2([0x80 | 0x04, 0x80])

# { RFM69_REG_05_FDEV_MSB, 0x00}, // 3000 hz (6000 hz shift)
rfm69.xfer2([0x80 | 0x05, 0x00])

# { RFM69_REG_06_FDEV_LSB, 0x31},
rfm69.xfer2([0x80 | 0x06, 0x31])

# Set Frequency
R69_FREG=int((Frequency * 1e6) / 61)
R69_FREG_MSB = ((R69_FREG >>16) & 0xFF)
R69_FREG_MID = ((R69_FREG >>8)  & 0xFF)
R69_FREG_LSB = ( R69_FREG       & 0xFF)
print "Set Frequency Regs to: " + hex(R69_FREG_MSB) + ", " + hex(R69_FREG_MID) + ", " + hex(R69_FREG_LSB)
rfm69.xfer2([0x80 | 0x07, R69_FREG_MSB])
#rfm69.xfer2([0x80 | 0x08, R69_FREG_MID])       # Calc gives 0x80 not 0x60
rfm69.xfer2([0x80 | 0x08, 0x60])
rfm69.xfer2([0x80 | 0x09, R69_FREG_LSB])

#{ RFM69_REG_11_PA_LEVEL,    RF_PALEVEL_PA0_OFF | RF_PALEVEL_PA1_ON | RF_PALEVEL_PA2_ON | 0x18},  // 10mW
rfm69.xfer2([0x80 | 0x11, 0x00 | 0x40 | 0x20 | 0x18])

#{ RFM69_REG_13_OCP,         RF_OCP_ON | RF_OCP_TRIM_95 },
rfm69.xfer2([0x80 | 0x13, 0x1a | 0x0a ])

#{ RFM69_REG_18_LNA, RF_LNA_ZIN_50 }, // 50 ohm for matched antenna, 200 otherwise
rfm69.xfer2([0x80 | 0x18, 0x00])

#{ RFM69_REG_19_RX_BW, RF_RXBW_DCCFREQ_010 | RF_RXBW_MANT_16 | RF_RXBW_EXP_2}, // Rx Bandwidth: 128KHz
rfm69.xfer2([0x80 | 0x19, 0x40 | 0x00 | 0x02 ])

# { RFM69_REG_1E_AFC_FEI, RF_AFCFEI_AFCAUTO_ON | RF_AFCFEI_AFCAUTOCLEAR_ON }, // Automatic AFC on, clear after each packet
rfm69.xfer2([0x80 | 0x1e, 0x04 | 0x08 ])

#{ RFM69_REG_25_DIO_MAPPING1, RF_DIOMAPPING1_DIO0_01 },
rfm69.xfer2([0x80 | 0x25, 0x40 ])

#{ RFM69_REG_26_DIO_MAPPING2, RF_DIOMAPPING2_CLKOUT_OFF }, // Switch off Clkout
rfm69.xfer2([0x80 | 0x26, 0x07 ])

#{ RFM69_REG_2E_SYNC_CONFIG, RF_SYNC_ON | RF_SYNC_FIFOFILL_AUTO | RF_SYNC_SIZE_2 | RF_SYNC_TOL_0 },
rfm69.xfer2([0x80 | 0x2e, 0x80 | 0x00 | 0x08 | 0x00 ])

#{ RFM69_REG_2F_SYNCVALUE1, 0x2D },
rfm69.xfer2([0x80 | 0x2f, 0x2d])

#{ RFM69_REG_30_SYNCVALUE2, 0xAA },
rfm69.xfer2([0x80 | 0x30, 0xaa ])

#{ RFM69_REG_37_PACKET_CONFIG1, RF_PACKET1_FORMAT_VARIABLE | RF_PACKET1_DCFREE_OFF | RF_PACKET1_CRC_ON | RF_PACKET1_CRCAUTOCLEAR_ON | RF_PACKET1_ADRSFILTERING_OF
#F },
rfm69.xfer2([0x80 | 0x37, 0x80 | 0x00 | 0x10 | 0x00 | 0x00 ])

#{ RFM69_REG_38_PAYLOAD_LENGTH, RFM69_FIFO_SIZE }, // Full FIFO size for rx packet
rfm69.xfer2([0x80 | 0x38, 64 ])

#{ RFM69_REG_3C_FIFO_THRESHOLD, RF_FIFOTHRESH_TXSTART_FIFONOTEMPTY | RF_FIFOTHRESH_VALUE }, //TX on FIFO not empty
rfm69.xfer2([0x80 | 0x3c, 0x80 | 0x0f ])

#{ RFM69_REG_3D_PACKET_CONFIG2, RF_PACKET2_RXRESTARTDELAY_2BITS | RF_PACKET2_AUTORXRESTART_ON | RF_PACKET2_AES_OFF }, //RXRESTARTDELAY must match transmitter PA ramp-down time (bitrate dependent)
rfm69.xfer2([0x80 | 0x3d, 0x10 | 0x02 | 0x00 ])


#{ RFM69_REG_6F_TEST_DAGC, RF_DAGC_IMPROVED_LOWBETA0 }, // run DAGC continuously in RX mode, recommended default for AfcLowBetaOn=0
rfm69.xfer2([0x80 | 0x6f, 0x30])


msg="2aL51.498,-0.0527T0R0:PiNode[MP]"


# Get OP Mode
OpMode=rfm69.xfer2([0x01,0x00])
print "Op Mode=[%s]"  % ', '.join(map('0x{0:02x}'.format, OpMode))

# Set TX Mode
OpMode=rfm69.xfer2([0x01,0x00])[1]
OpMode=(OpMode & 0xe3) | 0x0c   # Clear Mode flags and set TX Mode
rfm69.xfer2([0x80 | 0x01,OpMode])

# Send Message
rfm69.xfer2([0x80 | 0x00,len(msg)])
for c in msg:
  rfm69.xfer2([ord(c)])

time.sleep(0.1)
# Turn of TX
OpMode=rfm69.xfer2([0x01,0x00])[1]
OpMode=(OpMode & 0xe3) | 0x10   # Clear Mode flags and set RX Mode
rfm69.xfer2([0x80 | 0x01,OpMode])

# spiwrite RFM69_REG_25_DIO_MAPPING1, RF_DIOMAPPING1_DIO0_00);

