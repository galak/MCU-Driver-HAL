# Microsecond ticker

Implementing the microsecond ticker enables MCU-Driver-HAL to perform operations that require precise timing. You can use this API to schedule events, record elapsed time and perform submillisecond delays.

## Assumptions

### Defined behavior

- Has a reported frequency between 250 KHz and 8 MHz for counters that are less than 32 bits wide.
- Has a reported frequency up to 100 MHz for counters that are 32 bits wide.
- Has a counter that is at least 16 bits wide.
- The initialization function is safe to call repeatedly.
- The initialization function allows the ticker to keep counting and disables the ticker interrupt.
- Ticker frequency is nonzero, and the counter is at least 8 bits.
- The ticker rolls over at (1 << bits) and continues counting starting from 0.
- The ticker counts at the specified frequency ±10%.
- The ticker increments by 1 each tick.
- The ticker interrupt fires only when the ticker time increments to or past the value set by the set interrupt function.
- It is safe to call the set interrupt function repeatedly before the handler is called.
- The function to fire interrupt causes `ticker_irq_handler` to be called immediately from interrupt context.
- The read, clear interrupt, set interrupt and fire interrupt ticker operations take less than 20 us to complete.
- The init and read ticker operations are atomic.

### Undefined behavior

- Calling any function other than the initialization function before the initialization of the ticker.
- Whether `ticker_irq_handler` is called a second time if the time wraps and matches the value set by the set interrupt function again.
- Calling the set interrupt` fucntion with a value that has more than the supported number of bits.
- Calling any function other than the init function after calling the free function.

### Notes

Be careful around these common trouble areas when implementing this API:

- The ticker cannot drift when rescheduled repeatedly.
- The ticker keeps counting when it rolls over.
- The ticker interrupt fires when the compare value is set to 0 and overflow occurs.

## Dependencies

To implement this API, the device must have a hardware counter that has a count value at least 16 bits wide and can operate between 250 KHz and 8 MHz.

## Implementing the microsecond ticker API

You can find the API and specification for the microsecond ticker API in the following header file:

[![View code](../../images/view_library_button.png)](https://mcu-driver-hal.github.io/MCU-Driver-HAL/doxygen/html/group__hal__us__ticker.html)

To enable microsecond ticker support add `DEVICE_USTICKER=1` in the CMake variable `MBED_TARGET_DEFINITIONS`.

### Optimizing the microsecond ticker API

The generic ticker API uses the `ticker_info_t` structure to determine each hardware counter frequency and width. This then requires runtime calculations to convert between the hardware counter and the 64-bit microsecond count used by the generic API.

In addition to the generic `ticker_info_t`, the MCU can also provide compile time information about the microsecond ticker by defining the macros `US_TICKER_PERIOD_NUM`, `US_TICKER_PERIOD_DEN` and `US_TICKER_MASK`. If provided, these permit greatly optimized versions of APIs such as `wait_us`. See the header file for full details.

## Testing

MCU-Driver-HAL provides a set of conformance tests for the microsecond ticker. You can use these tests to validate the correctness of your implementation.

Steps to run the microsecond ticker HAL tests will be provided in the future.
