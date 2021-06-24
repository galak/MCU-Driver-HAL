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
        "-mcpu=cortex-m4"
    )
elseif(${COMPILER} STREQUAL "ARM")
    list(APPEND common_options
        "-mcpu=cortex-m4"
        "-mfpu=none"
    )
#Necessary as the linker does not always detect
#the architecture from the objectfiles correctly.
    list(APPEND link_options
        "--cpu=Cortex-M4.no_fp"
    )
endif()

function(mbed_set_cpu_core_definitions target)
    target_compile_definitions(${target}
        INTERFACE
            __CORTEX_M4
            ARM_MATH_CM4
            __CMSIS_RTOS
            __MBED_CMSIS_RTOS_CM
    )
endfunction()
