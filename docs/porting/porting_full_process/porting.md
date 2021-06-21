# Getting a working baseline

## Importing to your SDK

The MCU-Driver-HAL repository is intended to be included in your SDK repository. A copy of MCU-Driver-HAL can be included in your SDK repository.  
Alternatively, you can include a reference to MCU-Driver-HAL with tools such as Git submodule or CMake FetchContent.

Below is a step-by-step guide to include a Git submodule reference to your SDK.

1. In your SDK, navigate to the desired location for MCU-Driver-HAL:
    ```
    $ cd /path/to/desired/location/in/SDK/
    ```
1. Add MCU-Driver-HAL as a submodule to your SDK
    ```
    $ git submodule add git@github.com:mcu-driver-hal/MCU-Driver-HAL.git
    ```
    This adds a reference to the repository to the `.gitmodules` file at the root of your SDK repository to link MCU-Driver-HAL to it. The command also adds the `.gitmodules` and a SHA of the MCU-Driver-HAL to the index of the SDK repository.
1. Add a commit to your SDK:
    ```
    $ git commit -m "<YOUR COMMIT MESSAGE>"
    ```

  
<span class="notes">**Note:** Your SDK now includes a SHA reference of the MCU-Driver-HAL repository when the commit was made. Since the reference does not track a branch, it will not include any subsquent changes to the branch of MCU-Driver-HAL used when the commit was made.</span>

# Porting HAL APIs
## Building examples

Follow the steps described in the [examples README.md file](../../../examples/README.md) to help you test during the porting development process.

## Recommended porting order

Based on criticality and dependency of the software stack, we recommend the following order:

1. Bootstrap and entry point
1. Serial port (synchronous transfer)
1. Low power ticker
1. Microsecond ticker
1. GPIO and IRQ
1. RTC
1. SPI
1. TRNG
1. Flash
1. Optional HAL APIs

Detailed instructions for porting each module are given in the module-specific sections of this documentation.

### Bootstrap and entry point

MCU-Driver-HAL uses CMSIS-Core to bootstrap. If your hardware platform does not have a CMSIS implementation (distributed in CMSIS pack-form), you will need to create your own CMSIS files:

1. Locate [CMSIS Device Template files](https://www.keil.com/pack/doc/CMSIS/Core/html/templates_pg.html). 

1. Create linker scripts from the templates.

1. Implement pin mapping and basic peripheral initialization code. At this point, none of the peripherals for the new hardware platform have been implemented.

When the bootstrap and entry point are ready, replace the entire content of an example's `main.c` file with the code snippet below to test that it builds successfully:
```c
int main(void) {
    while(1);
    return 0;
}
```


### Serial Port (synchronous transfer)
[Serial port porting instructions](../api/serial.md).

Serial port porting can be done in two stages: synchronous UART and asynchronous UART. We recommend porting synchronous UART as early as possible, because the HAL Greentea tests require it, and because `printf()` is a powerful debugging tool.

### Low power ticker
[Low power ticker porting instructions](../api/lp_ticker.md).

<span class="notes">**Note**: Low power ticker is recommended for any board that supports it.</span>

### Microsecond Ticker

[Microsecond ticker porting instructions](../api/us_ticker.md).

When you finish porting the microsecond ticker, the `wait` API should work, and the intervals should be exact. You can verify this with `printf`.

### GPIO (write and read) and IRQ

[GPIO porting instructions](../api/gpio.md).

The GPIO examples is great for debugging with an oscilloscope or logic analyzer.

### RTC

[RTC porting instructions](../api/rtc.md).

On some hardware platforms, RTC is shared with low power ticker and you can only use one of them. On these hardware platforms, you must use low power ticker instead of RTC.

### SPI (controller)

SPI (controller) is used to communicate with storage devices that have an SPI interface, such as SD cards.

RTC is a dependency of SPI (controller) tests.

### TRNG

[True random number generator entropy source (TRNG) porting instructions](../api/trng.md).

### Flash

[Flash porting instructions](../api/flash.md).

The flash API can be implemented using CMSIS flash algorithms or C source code. We recommend using C source code, because it is easier to maintain and upgrade. It is also more portable to use C source code across different boards.

### Optional HAL APIs

You are now ready to port any other HAL modules that your use case and MCU require. These modules are covered in the rest of this document.
