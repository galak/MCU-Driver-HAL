<h1 id="resetreason-port">ResetReason</h1>

The `ResetReason` API provides a platform-independent method of checking the cause of the last system reset. Implementing the ResetReason API is not mandatory, but by implementing it, you can check for erroneous system resets at boot time.

## Assumptions

### Defined behavior

- The function `hal_reset_reason_clear` clears the ResetReason registers for the next system boot.
- By the time the user calls `hal_reset_reason_get` to read the value, some other part of the application may have cleared the value. Therefore, though there may have been a reset reason in the registers when the system started, the reason may not be available when the user comes to check it.

### Undefined behavior

- There is no guarantee that the function `hal_reset_reason_get` will return the same value when you call it repeatedly. Store the value for later use instead of calling the function repeatedly.
- The function `hal_reset_reason_clear` may not clear the ResetReason register in time for the next system boot.

### Notes

- The contents of the targets ResetReason register may be cleared by some subsystem before it first gets called. This returns a `RESET_REASON_UNKNOWN` value to the user. To avoid this, the user should call the ResetReason API as early as possible at boot time.
- If the target does not support clearing reset registers, `hal_reset_reason_get` seems to erroneously return a reset reason even after clearing.

## Dependency

Hardware ResetReason registers.

## Implementing ResetReason

You can find the API and specification for the ResetReason API in the following header file:

[![View code](../../images/view_library_button.png)](https://mcu-driver-hal.github.io/MCU-Driver-HAL/doxygen/html/group__hal__reset__reason.html)

To enable ResetReason HAL support add `DEVICE_RESET_REASON=1` in the CMake variable `MBED_TARGET_DEFINITIONS`.

## Testing

MCU-Driver-HAL provides a set of conformance tests for ResetReason. You can use these tests to validate the correctness of your implementation.

Steps to run the ResetReason HAL tests will be provided in the future.
