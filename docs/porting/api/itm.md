<h1 id="itm-port">Instrumentation Trace Macrocell</h1>

For MCUs with Arm [CoreSight](http://infocenter.arm.com/help/index.jsp?topic=/com.arm.doc.ddi0314h/) (for example, Cortex-M3 and Cortex-M4), the Instrumentation Trace Macrocell (ITM) provides a lightweight, nonintrusive way to collect debug trace output.

## Assumptions

### Defined behavior

When the ITM has been initialized, writing data to the ITM stimulus registers results in the ITM transmitting the data over the SWO line.

### Undefined behaviors

- The debug clock frequency is left undefined because the most optimal frequency varies by MCU. It is up to each board owner to choose a frequency that does not interfere with normal operation and that of the owner's preferred debug monitor supports.
- If another peripheral tries to take control of the SWO pin, it is undefined whether or not that operation succeeds.

### Note

Some SWO viewers do not allow an arbitrary frequency to be set. Make sure the development tools you expect your users to use support the chosen frequency.

## Dependencies

- The target supports Arm CoreSight.
- The target has SWO connected either to a compatible interface chip or exposed as a debug pin.

## Implementing the ITM API

[![View code](../../images/view_library_button.png)](https://mcu-driver-hal.github.io/MCU-Driver-HAL/doxygen/html/group__itm__hal.html)

- You must implement the function `itm_init`. When the function is called:
  - The function must initialize the debug clock for the ITM.
  - The function must configure the SWO pin for debug output.
- You must add `DEVICE_ITM=1` in the CMake variable `MBED_TARGET_DEFINITIONS`.

It is not necessary to modify any of the ITM registers in `itm_init`, except for the one related to the clock prescaling, `TPI->ACPR`. The helper function `mbed_itm_init` is responsible for calling `itm_init` and initializing the generic ITM registers. `mbed_itm_init` only calls the function `itm_init` once, making it unnecessary to protect `itm_init` against multiple initializations.

## Testing

Steps to test ITM will be provided in the future.
