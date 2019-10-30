
####################
# UNIT TESTS
####################

set(unittest-includes ${unittest-includes}
  .
  ..
  ../drivers/internal
  ../hal/usb
  ../features/mbedtls/mbed-crypto/inc/mbedtls/
  ../features/mbedtls/platform/inc/
  ../features/frameworks/mbed-trace/mbed-trace/
)

set(unittest-sources
	../drivers/source/AnalogOut.cpp
	../drivers/source/I2C.cpp
	../drivers/source/QSPI.cpp
	../drivers/source/SPISlave.cpp
	../drivers/source/SerialWireOutput.cpp
	../drivers/source/AnalogIn.cpp
	../drivers/source/InterruptIn.cpp
	../drivers/source/Timer.cpp
	../drivers/source/DigitalIn.cpp
	../drivers/source/PortInOut.cpp
	../drivers/source/Ethernet.cpp
	../drivers/source/DigitalInOut.cpp
	../drivers/source/Watchdog.cpp
	../drivers/source/SPI.cpp
	../drivers/source/ResetReason.cpp
	../drivers/source/I2CSlave.cpp
	../drivers/source/PwmOut.cpp
	../drivers/source/usb/ByteBuffer.cpp
	../drivers/source/usb/OperationListBase.cpp
	../drivers/source/usb/USBDevice.cpp
	../drivers/source/usb/LinkedListBase.cpp
	../drivers/source/usb/PolledQueue.cpp
	../drivers/source/usb/TaskBase.cpp
	../drivers/source/usb/USBCDC.cpp
	../drivers/source/usb/USBMSD.cpp
	../drivers/source/usb/AsyncOp.cpp
	../drivers/source/usb/USBAudio.cpp
	../drivers/source/usb/USBHID.cpp
	../drivers/source/usb/USBKeyboard.cpp
	../drivers/source/usb/USBSerial.cpp
	../drivers/source/usb/USBCDC_ECM.cpp
	../drivers/source/usb/USBMIDI.cpp
	../drivers/source/usb/EndpointResolver.cpp
	../drivers/source/usb/USBMouseKeyboard.cpp
	../drivers/source/usb/USBMouse.cpp
	../drivers/source/PortOut.cpp
	../drivers/source/MbedCRC.cpp
	../drivers/source/FlashIAP.cpp
	../drivers/source/Serial.cpp
	../drivers/source/RawSerial.cpp
	../drivers/source/CAN.cpp
	../drivers/source/BusIn.cpp
	../drivers/source/BusInOut.cpp
	../drivers/source/InterruptManager.cpp
	../drivers/source/DigitalOut.cpp
	../drivers/source/PortIn.cpp
	../drivers/source/TableCRC.cpp
	../drivers/source/UARTSerial.cpp
	../drivers/source/SerialBase.cpp
	../drivers/source/BusOut.cpp
	../drivers/source/TimerEvent.cpp
	../events/source/EventQueue.cpp
	../features/device_key/source/DeviceKey.cpp
	../components/storage/blockdevice/COMPONENT_SPIF/SPIFBlockDevice.cpp
	../components/storage/blockdevice/COMPONENT_I2CEE/I2CEEBlockDevice.cpp
	../components/storage/blockdevice/COMPONENT_DATAFLASH/DataFlashBlockDevice.cpp
	../components/storage/blockdevice/COMPONENT_FLASHIAP/FlashIAPBlockDevice.cpp
	../components/storage/blockdevice/COMPONENT_RSPIF/SPIFReducedBlockDevice.cpp
	../components/storage/blockdevice/COMPONENT_SD/SDBlockDevice.cpp
	../components/storage/blockdevice/COMPONENT_QSPIF/QSPIFBlockDevice.cpp
	../features/storage/filesystem/Dir.cpp
	../features/storage/filesystem/FileSystem.cpp
	../features/storage/filesystem/File.cpp
	../features/storage/kvstore/global_api/kvstore_global_api.cpp
	../features/storage/kvstore/securestore/SecureStore.cpp
	../features/storage/kvstore/kv_map/KVMap.cpp
	../features/storage/kvstore/tdbstore/TDBStore.cpp
	../features/storage/kvstore/direct_access_devicekey/DirectAccessDevicekey.cpp
	../features/storage/kvstore/conf/kv_config.cpp
	../features/storage/kvstore/filesystemstore/FileSystemStore.cpp
	../features/storage/system_storage/SystemStorage.cpp
	../features/storage/nvstore/source/nvstore.cpp
	../features/storage/blockdevice/ChainingBlockDevice.cpp
	../features/storage/blockdevice/ReadOnlyBlockDevice.cpp
	../features/storage/blockdevice/SlicingBlockDevice.cpp
	../features/storage/blockdevice/MBRBlockDevice.cpp
	../features/storage/blockdevice/HeapBlockDevice.cpp
	../features/storage/blockdevice/FlashSimBlockDevice.cpp
	../features/storage/blockdevice/ObservingBlockDevice.cpp
	../features/storage/blockdevice/ProfilingBlockDevice.cpp
	../features/storage/blockdevice/BufferedBlockDevice.cpp
	../features/storage/blockdevice/ExhaustibleBlockDevice.cpp
)

set(unittest-test-sources
  empty_baseline/empty_baseline.cpp
)

set(DEVICE_FLAGS "-DDEVICE_ANALOGIN -DDEVICE_ANALOGOUT -DDEVICE_CAN -DDEVICE_CRC -DDEVICE_ETHERNET -DDEVICE_FLASH -DDEVICE_I2C -DDEVICE_I2CSLAVE -DDEVICE_I2C_ASYNCH -DDEVICE_INTERRUPTIN -DDEVICE_LPTICKER -DDEVICE_PORTIN -DDEVICE_PORTINOUT -DDEVICE_PORTOUT -DDEVICE_PWMOUT -DDEVICE_QSPI -DDEVICE_SERIAL -DDEVICE_SERIAL_ASYNCH -DDEVICE_SERIAL_FC -DDEVICE_SPI -DDEVICE_SPISLAVE -DDEVICE_SPI_ASYNCH -DDEVICE_FLASH -DCOMPONENT_FLASHIAP")
set(CONF_FLAGS "-DMBED_CONF_PLATFORM_CTHUNK_COUNT_MAX=10 -DMBED_CONF_DATAFLASH_SPI_FREQ=1 -DMBED_CONF_FLASHIAP_BLOCK_DEVICE_BASE_ADDRESS=0 -DMBED_CONF_FLASHIAP_BLOCK_DEVICE_SIZE=0 -DMBED_CONF_QSPIF_QSPI_FREQ=1 -DMBED_CONF_QSPIF_QSPI_MIN_READ_SIZE=1 -DMBED_CONF_QSPIF_QSPI_MIN_PROG_SIZE=1 -DMBED_LFS_READ_SIZE=64 -DMBED_LFS_PROG_SIZE=64 -DMBED_LFS_BLOCK_SIZE=512 -DMBED_LFS_LOOKAHEAD=512 -DFLASHIAP_APP_ROM_END_ADDR=0x80000 -DMBED_CONF_STORAGE_TDB_INTERNAL_INTERNAL_SIZE=1024 -DMBED_CONF_STORAGE_TDB_INTERNAL_INTERNAL_BASE_ADDRESS=0x80000 -DMBED_CONF_STORAGE_STORAGE_TYPE=default")
set(CMAKE_C_FLAGS "${CMAKE_C_FLAGS} ${DEVICE_FLAGS} ${CONF_FLAGS}")
set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} ${DEVICE_FLAGS} ${CONF_FLAGS}")
