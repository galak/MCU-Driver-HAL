<h1 id="i2c-port">Inter-integrated circuit (I2C) </h1>

---
**Note**

The _Master/Slave_ terminology for I2C is considered obsolete. _Master_ is now _Controller_ and _Slave_ is now _Peripheral_, this will reflected in the API in the future.

---

I2C is a serial protocol for two-wire interface to connect low-speed devices in embedded systems. The I2C API allows control and configuration of this interface.

The interface is made up of two lines for all communication:
- Serial Clock (SCL).
- Serial Data (SDA).

## Defined behaviors

- `i2c_init`:
   - Initializes the peripheral pins specified in the input parameters.
   - Initializes in Controller or Peripheral mode depending on the state of the `i2c_t` object.
   - Initializes all `i2c_t` object fields.
- `i2c_free`:
   - Resets the pins used to initialize the peripheral to their default state.
   - Disables the peripheral clock.
- `i2c_frequency`:
   - Sets the frequency to use for the transfer.
   - Must leave all other configuration unchanged.
- `i2c_write`:
   - Writes `length` number of symbols to the bus.
   - Returns the number of symbols sent to the bus.
   - Returns an negative integer if transfer fails.
   - Generates a stop condition on the bus at the end of the transfer if `stop` parameter is a positive integer.
   - Handles transfer collisions and loss of arbitration if the platform supports multi-controller in hardware.
   - The transfer times out and returns a negative integer if the transfer takes longer than the configured timeout duration.
- `i2c_read`:
   - Reads `length` symbols from the bus.
   - Returns the number of symbols received from the bus.
   - Returns a negative integer if transfer fails.
   - Generates a stop condition on the bus at the end of the transfer if the `stop` parameter is a positive integer.
   - Handles transfer collisions and loss of arbitration if the platform supports multi-controller in hardware.
   - The transfer times out and returns a negative integer value if the transfer takes longer than the configured timeout duration.
- `i2c_start`:
   - Generates I2C START condition on the bus in Controller mode.
   - Does nothing if called when configured in Peripheral mode.
- `i2c_stop`:
   - Generates I2C STOP condition on the bus in Controller mode.
   - Does nothing if configured in Peripheral mode.
- `i2c_slave_address`:
   - Sets the address of the peripheral to the `address` parameter.
   - Does nothing if called in Controller mode.
- `i2c_transfer_async`:
   - The callback given to `i2c_transfer_async` is invoked when the transfer finishes or error occurs.
   - Must save the handler and context pointers inside the `obj` pointer.
   - The context pointer is passed to the callback on transfer completion.
   - The callback must be invoked on completion unless the transfer is aborted.
   - May handle transfer collisions and loss of arbitration if the platform supports multi-controller in hardware and enabled in API.
- `i2c_abort_async`:
   - Aborts any ongoing async transfers.

## Undefined behaviors

- Use of a null pointer as an argument to any function.
- Calling any I2C function before calling `i2c_init` or after calling `i2c_free`.
- Initializing the I2C peripheral with invalid `SDA` and `SCL` pins.
- Initializing in Peripheral mode if Peripheral mode is not supported.
- Operating in Peripheral mode without first specifying and address using `i2c_slave_address`.
- Setting an address using `i2c_slave_address` after initializing in Controller mode.
- Setting an address to an I2C reserved value.
- Setting an address larger than the 7-bit supported maximum if 10-bit addressing is not supported.
- Setting an address larger than the 10-bit supported maximum.
- Setting a frequency outside the supported range.
- Specifying an invalid address when calling read or write functions.
- Setting the length of the transfer or receive buffers to larger than the buffers are.
- Passing an invalid `handler` to `i2c_transfer_async`.
- Calling `i2c_transfer_abort` when no transfer is currently in progress.

## Dependencies

Hardware I2C capabilities.

## Implementing the I2C API

You can find the API and specification for the I2C API in the header file:

[![View code](../../images/view_library_button.png)](https://mcu-driver-hal.github.io/MCU-Driver-HAL/doxygen/html/group__hal___general_i2_c.html)

To enable I2C support add `DEVICE_I2C=1` in the CMake variable `MBED_TARGET_DEFINITIONS`.
You can also add the `DEVICE_I2C_ASYNCH=1` in the CMake variable `MBED_TARGET_DEFINITIONS` to enable the asynchronous API,
and `DEVICE_I2CSLAVE=1` to enable the I2CSlave API.

## Testing

MCU-Driver-HAL provides a set of conformance tests for I2C. You can use these tests to validate the correctness of your implementation.

Steps to run the I2C HAL tests will be provided in the future.
