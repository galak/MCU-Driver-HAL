# Sleep

Implement the Sleep HAL API to enable your device to go into a low power state when you are not actively using it.

## Assumptions

### Defined behavior

There are two power-saving modes available in MCU-Driver-HAL:
* Sleep
* Deep sleep

#### Sleep

The core system clock is disabled. You can use both the low and high frequency clocks and retain RAM.

1. Wake-up sources: Any interrupt must wake up the MCU.
1. Latency: The MCU must wake up within 10 us.

#### Deep sleep

The core system clock is disabled. You can only enable the low frequency clocks and retain RAM.

1. Wake-up sources: RTC, low power ticker or GPIO must wake up the MCU.
1. Latency: The MCU must wake up within 10 ms.

## Implementing the Sleep API

You can find the API and specification for the sleep API in the following header file:

[![View code](../../images/view_library_button.png)](https://mcu-driver-hal.github.io/MCU-Driver-HAL/doxygen/html/group__hal__sleep.html)


To enable sleep support add `DEVICE_SLEEP=1` in the CMake variable `MBED_TARGET_DEFINITIONS`.

---

**Warning**

If your MCU disables `systick` when entering sleep mode, add `DEVICE_SYSTICK_CLK_OFF_DURING_SLEEP` in the CMake variable `MBED_TARGET_DEFINITIONS`. This disables sleep when an RTOS is present to ensure the scheduler works as expected.

---

## Testing

MCU-Driver-HAL provides a set of conformance tests for Sleep. You can use these tests to validate the correctness of your implementation.

Steps to run the Sleep HAL tests will be provided in the future.
