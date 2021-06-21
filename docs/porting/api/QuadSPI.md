<h1 id="quadspi-port">QuadSPI (QSPI) </h1>

Implementing QSPI enables MCU-Driver-HAL to communicate with compliant external SPI devices much faster than with standalone SPI due to the inclusion of up to four data lines between the host and a device.

The most common use case is for external memory to use as additional data storage.

## Assumptions

### Defined behavior

- An MCU implementation covers most of the QSPI frame format (some MCUs might not provide the flexibility for setting all frame parameters).
- Command transfer - An MCU might provide additional functions for sending device specific commands. If it does not, you can implement it using read and write functions. This is MCU or driver dependent.

### Undefined behavior

- Calling any function other than `qspi_init` before the initialization of the QSPI.

### Dependency

QSPI peripheral

## Implementing QSPI

You can implement your own QSPI by pulling in the following API header file:

[![View code](../../images/view_library_button.png)](https://mcu-driver-hal.github.io/MCU-Driver-HAL/doxygen/html/group__hal__qspi.html)

The MCU needs to define the `qspi_s` structure - MCU specific QSPI object.

The MCU needs to define the QSPI interface pin names:

- `QSPI_FLASHn_XXX` for pins connected to onboard flash memory.
- `QSPIn_XXX` for pins routed out to external connector.

`n` is the interface index, typically `1` if single QSPI interface available.

I.e
```
QSPIn_IO0
QSPIn_IO1
QSPIn_IO2
QSPIn_IO3
QSPIn_SCK
QSPIn_CSN

QSPI_FLASHn_IO0
QSPI_FLASHn_IO1
QSPI_FLASHn_IO2
QSPI_FLASHn_IO3
QSPI_FLASHn_SCK
QSPI_FLASHn_CSN
```

Functions to implement:

```c
qspi_status_t qspi_init(qspi_t *obj, PinName io0, PinName io1, PinName io2, PinName io3, PinName sclk, PinName ssel, uint32_t hz, uint8_t mode);
qspi_status_t qspi_free(qspi_t *obj);
qspi_status_t qspi_frequency(qspi_t *obj, int hz);
qspi_status_t qspi_write(qspi_t *obj, const qspi_command_t *command, const void *data, size_t *length);
qspi_status_t qspi_command_transfer(qspi_t *obj, const qspi_command_t *command, const void *tx_data, size_t tx_size, void *rx_data, size_t rx_size);
qspi_status_t qspi_read(qspi_t *obj, const qspi_command_t *command, void *data, size_t *length);
```

Use `qspi_write` and `qspi_read` for data transfers.  
To communicate with a device, use `qspi_command_transfer`.

To enable QSPI HAL support add `DEVICE_QSPI=1` in the CMake variable `MBED_TARGET_DEFINITIONS`.


## Testing

MCU-Driver-HAL provides a set of conformance tests for the QSPI interface.

<span class="notes">**Note:** QSPI HAL tests require QSPI Flash pins to be defined.</span>

You can use these tests to validate the correctness of your implementation.

Steps to run the QSPI HAL tests will be provided in the future.
