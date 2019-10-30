
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
)

set(unittest-test-sources
  empty_baseline/empty_baseline.cpp
)

set(CMAKE_C_FLAGS "${CMAKE_C_FLAGS} -DMBED_CONF_PLATFORM_CTHUNK_COUNT_MAX=10 -DDEVICE_ANALOGIN -DDEVICE_ANALOGOUT -DDEVICE_CAN -DDEVICE_CRC -DDEVICE_ETHERNET -DDEVICE_FLASH -DDEVICE_I2C -DDEVICE_I2CSLAVE -DDEVICE_I2C_ASYNCH -DDEVICE_INTERRUPTIN -DDEVICE_LPTICKER -DDEVICE_PORTIN -DDEVICE_PORTINOUT -DDEVICE_PORTOUT -DDEVICE_PWMOUT -DDEVICE_QSPI -DDEVICE_SERIAL -DDEVICE_SERIAL_ASYNCH -DDEVICE_SERIAL_FC -DDEVICE_SPI -DDEVICE_SPISLAVE -DDEVICE_SPI_ASYNCH -DDEVICE_FLASH -DCOMPONENT_FLASHIAP")
set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -DMBED_CONF_PLATFORM_CTHUNK_COUNT_MAX=10 -DDEVICE_ANALOGIN -DDEVICE_ANALOGOUT -DDEVICE_CAN -DDEVICE_CRC -DDEVICE_ETHERNET -DDEVICE_FLASH -DDEVICE_I2C -DDEVICE_I2CSLAVE -DDEVICE_I2C_ASYNCH -DDEVICE_INTERRUPTIN -DDEVICE_LPTICKER -DDEVICE_PORTIN -DDEVICE_PORTINOUT -DDEVICE_PORTOUT -DDEVICE_PWMOUT -DDEVICE_QSPI -DDEVICE_SERIAL -DDEVICE_SERIAL_ASYNCH -DDEVICE_SERIAL_FC -DDEVICE_SPI -DDEVICE_SPISLAVE -DDEVICE_SPI_ASYNCH -DDEVICE_FLASH -DCOMPONENT_FLASHIAP")