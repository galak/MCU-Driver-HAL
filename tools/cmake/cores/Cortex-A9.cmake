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

if(${COMPILER} STREQUAL "GCC_ARM")
    list(APPEND common_options
        "-mthumb-interwork"
        "-marm"
        "-mfpu=vfpv3"
        "-mfloat-abi=softfp"
        "-mno-unaligned-access"
        "-mcpu=cortex-a9"
    )
elseif(${COMPILER} STREQUAL "ARM")
    list(APPEND common_options
        "-mfpu=vfpv3"
        "-mfloat-abi=hard"
        "-mcpu=cortex-a9"
    )
endif()

function(mbed_set_cpu_core_definitions target)
    target_compile_definitions(${target}
        INTERFACE
            __CORTEX_A9
            ARM_MATH_CA9
            __FPU_PRESENT
            __CMSIS_RTOS
            __EVAL
            __MBED_CMSIS_RTOS_CA9
    )
endfunction()
