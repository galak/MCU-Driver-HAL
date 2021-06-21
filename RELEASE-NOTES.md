# Release notes

This document contains details of releases for the `MCU-Driver-HAL` repository.

0.1.0 (2021-06-18)
===================

Features
--------

* Initial version of HAL API based on Mbed OS HAL 6.11.0
  * analogin, analogout
  * can
  * crc
  * flash
  * gpio
  * i2c
  * itm
  * ticker, lp_ticker, us_ticker
  * mpu
  * ospi
  * pinmap, static_pinmap
  * pwmout
  * qspi
  * reset_reason
  * rtc
  * serial
  * sleep
  * spi
  * trng
  * watchdog
* HAL API Doxygen [documentation](https://mcu-driver-hal.github.io/MCU-Driver-HAL/doxygen/html/index.html)
* HAL porting guide [documentation](https://github.com/mcu-driver-hal/MCU-Driver-HAL/blob/main/docs/porting/PORTING.md)
* [Example applications](https://github.com/mcu-driver-hal/MCU-Driver-HAL/tree/main/examples#provided-examples)
  * flash, gpio, interrupt, serial, spi, trace, trng, us_ticker
* Greentea tests
  * Echo Serial
  * Other tests are not yet enabled
