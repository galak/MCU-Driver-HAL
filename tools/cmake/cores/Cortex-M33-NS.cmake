# Copyright (c) 2020-2021 Arm Limited
# SPDX-License-Identifier: Apache-2.0
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

# Sets cpu core options
if(${COMPILER} STREQUAL "GCC_ARM")
    list(APPEND common_options
        "-mthumb"
        "-mcpu=cortex-m33+nodsp+nofp"
    )
elseif(${COMPILER} STREQUAL "ARM")
    list(APPEND common_options
        "-mcpu=cortex-m33+nodsp"
        "-mfpu=none"
    )
    list(APPEND link_options
        # Necessary as the linker does not always detect
        # the architecture from the objectfiles correctly.
        # Also, the complete flag should be "--cpu=Cortex-M33.no_dsp.no_fp"
        # but this currently conflicts with CMake's compiler test until fixed
        "--cpu=Cortex-M33.no_fp"
    )
endif()

function(mbed_set_cpu_core_definitions target)
    target_compile_definitions(${target}
        INTERFACE
            __CORTEX_M33
            ARM_MATH_ARMV8MML
            DOMAIN_NS=1
            __CMSIS_RTOS
            __MBED_CMSIS_RTOS_CM
    )
endfunction()
