# Low Power Ticker

Implementing the low power ticker enables MCU-Driver-HAL to perform power efficient timing operations that only request millisecond accuracy. You can use this API to schedule events, and record elapsed time.

## Assumptions

### Defined behavior
- Has a reported frequency between 8KHz and 64KHz.
- Has a counter that is at least 12 bits wide.
- Continues operating in deep sleep mode.
- The function `lp_ticker_init` is safe to call repeatedly.
- The function `lp_ticker_init` allows the ticker to keep counting and disables the ticker interrupt.
- Ticker frequency is nonzero and the counter is at least 8 bits.
- The ticker rolls over at (1 << bits) and continues counting starting from 0.
- The ticker counts at the specified frequency plus or minus 10%.
- The ticker increments by 1 each tick.
- The ticker interrupt fires only when the ticker time increments to or past the value that `lp_ticker_set_interrupt` sets.
- It is safe to call `lp_ticker_set_interrupt` repeatedly before the handler is called.
- The function `lp_ticker_fire_interrupt` causes `lp_ticker_irq_handler` to be called immediately from interrupt context.
- The ticker operations `lp_ticker_read`, `lp_ticker_clear_interrupt`, `lp_ticker_set_interrupt` and `lp_ticker_fire_interrupt` take less than 20us to complete.

### Undefined behavior

- Calling any function other than `lp_ticker_init` before the initialization of the ticker.
- Whether `lp_ticker_irq_handler` is called a second time if the time wraps and matches the value that `lp_ticker_set_interrupt` again sets.
- Calling `lp_ticker_set_interrupt` with a value that has more than the supported number of bits.
- Calling any function other than `lp_ticker_init` after calling `lp_ticker_free`.

### Notes

Be careful around these common trouble areas when implementing this API:

- The ticker cannot drift when rescheduled repeatedly
- The ticker keeps counting when it rolls over
- The ticker interrupt fires when the compare value is set to 0 and and overflow occurs

### Handling synchronization delay

Some low power tickers require multiple low power clock cycles for the compare value that `lp_ticker_set_interrupt` sets to take effect. Further complicating this issue, a new compare value typically cannot be set until the first has taken effect. Because of this, when you make back-to-back calls to `lp_ticker_set_interrupt` without a delay, the second call blocks and violates the above requirement that `lp_ticker_set_interrupt` completes in 20us.

To meet this timing requirement, boards that have this synchronization delay must set `LPTICKER_DELAY_TICKS` to the number of low power clock cycles it takes for a call to `lp_ticker_set_interrupt` to take effect. When the targets set this value, the timer code prevents `lp_ticker_set_interrupt` from being called twice within that number of clock cycles. It does this by using the microsecond time to schedule the write to happen at a future date.

## Dependencies

Hardware low power ticker capabilities.

## Implementing the low power ticker API

You can find the API and specification for the low power ticker API in the following header file:
<!-- TODO: There is no doxygen documentation for this, it needs to be added -->
[![View code](../../images/view_library_button.png)](https://mcu-driver-hal.github.io/MCU-Driver-HAL/doxygen/html/group__hal__lp__ticker.html)

To enable low power ticker support add `DEVICE_LPTICKER=1` in the CMake variable `MBED_TARGET_DEFINITIONS`.

## Testing

MCU-Driver-HAL provides a set of conformance tests for the low power ticker. You can use these tests to validate the correctness of your implementation.

Steps to run the low power ticker HAL tests will be provided in the future.
