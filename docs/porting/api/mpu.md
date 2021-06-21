<h1 id="mpu-port">MPU</h1>

Implementing the MPU API enables MCU-Driver-HAL to provide better security by preventing code execution and code modification where it should not be allowed.

## Assumptions

### Defined behavior

- The function `mbed_mpu_init` is safe to call repeatedly.
- The function `mbed_mpu_free` disables MPU protection.
- Execution from RAM results in a fault when "execute never" is enabled. This RAM includes heap, stack, data and zero init.
- Writing to ROM results in a fault when "write never" is enabled.

### Undefined behavior

- Calling any function other than `mbed_mpu_init` before the initialization of the MPU.

## Dependency

Hardware MPU capabilities.

## Implementing the MPU API

You can find the API and specification for the MPU API in the following header file:

[![View code](../../images/view_library_button.png)](https://mcu-driver-hal.github.io/MCU-Driver-HAL/doxygen/html/group__hal__mpu.html)

MCUs with a standard ARMv7-M or ARMv8-M MPU, indicated by `__MPU_PRESENT` being defined to 1 in the MCU CMSIS header, support MPU.
To enable MPU support add `DEVICE_MPU=1` in the CMake variable `MBED_TARGET_DEFINITIONS`.
This pulls in a common MCU-Driver-HAL MPU driver, so you do not need a board specific driver.

MCU with a standard ARMv7-M or ARMv8-M MPU needing to override the common MCU-Driver-HAL MPU driver can do so by defining `MBED_MPU_CUSTOM`. This removes the common MCU-Driver-HAL MPU driver from builds, so you can use a board specific one instead.

## Testing

MCU_Driver-HAL provides a set of conformance tests for the MPU API. You can use these tests to validate the correctness of your implementation.

Steps to run the MPU HAL tests will be provided in the future.
