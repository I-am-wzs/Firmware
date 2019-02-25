#!/bin/bash
# Install FastRTPS 1.5.0 and FastCDR-1.0.7
dname=$(dirname "$PWD")
rm -rf $dname/toolschain/eProsima_FastCDR-1.0.7-Linux
rm -rf $dname/toolschain/eProsima_FastRTPS-1.5.0-Linux
rm -rf $dname/toolschain/gcc-arm-none-eabi-7-2017-q4-major

