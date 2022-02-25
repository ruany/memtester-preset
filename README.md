# Introduction
Memtester script for checking DRAM OC stability as quickly as possible under linux.

This script only runs the tests which I've found to have the highest failure rate under unstable DDR4 memory (Bit Flip, Walking Zeroes).

Based on my own tests, this script tends to report failure within under 5 seconds on highly unstable memory, and under 5 minutes for slightly unstable memory.

Since it only tests 600M per instance, it is not designed to find stuck bits, though it may find them by accident.
