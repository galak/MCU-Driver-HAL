<h1 id="serial-port">Serial</h1>

## Implementing the Serial API

You can find the API and specification for the Serial API in the following header file:

[![View code](../../images/view_library_button.png)](https://mcu-driver-hal.github.io/MCU-Driver-HAL/doxygen/html/group__hal___general_serial.html)

You must define the `serial_s` struct in an `objects.h` file. You may use the `serial_s` struct for referencing the serial memory-mapped peripheral registers and passing related pin and peripheral operation information data that the HAL requires.

To enable Serial support add `DEVICE_SERIAL=1` in the CMake variable `MBED_TARGET_DEFINITIONS`.


## Testing

MCU_Driver-HAL provides a set of conformance tests for the serial API. You can use these tests to validate the correctness of your implementation.

Steps to run the Serial HAL tests will be provided in the future.
