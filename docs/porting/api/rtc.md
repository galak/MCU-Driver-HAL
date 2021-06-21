<h1 id="rtc-port">RTC</h1>

Implementing RTC enables MCU-Driver-HAL to keep track of the current time. The standard library time keeping functions, such as `time`, uses it.

## Assumptions

### Defined behavior

- The function `rtc_init` is safe to call repeatedly.
- RTC accuracy is at least 10%.
- Neither `rtc_init` nor `rtc_free` stop RTC from counting.
- Software reset does not stop RTC from counting.
- Sleep modes do not stop RTC from counting.
- Shutdown mode does not stop RTC from counting.

### Undefined behavior

- Calling any function other than `rtc_init` before the initialization of the RTC.

### Notes

Watch out for these common trouble areas when implementing this API:

- Incorrect overflow handling.
- Glitches due to ripple counter.

## Dependencies

Hardware RTC capabilities.

## Implementing the RTC API

You can find the API and specification for the RTC API in the following header file:

[![View code](../../images/view_library_button.png)](https://mcu-driver-hal.github.io/MCU-Driver-HAL/doxygen/html/group__hal__rtc.html)

To enable RTC support add `DEVICE_RTC=1` in the CMake variable `MBED_TARGET_DEFINITIONS`.

## Testing

MCU-Driver-HAL provides a set of conformance tests for RTC. You can use these tests to validate the correctness of your implementation.

Steps to run the RTC HAL tests will be provided in the future.
