# Introduction
Memtester script for checking DRAM OC stability as quickly as possible under linux.

This script only runs the tests which I've found to have the highest failure rate under unstable DDR4 memory (Bit Flip, Walking Zeroes).

Based on my own tests, this script tends to report failure within under 5 seconds on highly unstable memory, and under 5 minutes for slightly unstable memory.

Since it only tests 1200M per instance, it is not designed to find stuck bits, though it may find them by accident.

# Tips
* Obviously make backups before testing in userspace.
* Try to avoid writing to the filesystem while the test is in progress.
* It can be a good idea to wait a few seconds before rebooting after a failed test, because 1) entering BIOS with hot memory can easily result in corrupted CMOS. 2) syncing filesystems while memory is hot increases risk of filesystem corruption.
* It's recommended to run this script with another stress test running in the background, or while playing an online game that can be safely interrupted in the event of a crash (no save file corruption).

My personal favourite concurrent test is y-cruncher with N32 and HNT tests across 6-10 physical cores. These tests failed within 4-5 seconds where other tests would take 30-50 seconds to fail under the same configuration.
Running concurrent stress tests puts specific stress on the memory controller that can make both or either of the tests fail when they otherwise wouldn't.

Compiling LLVM with Clang is another great stress test (Linux 6.1 will log which CPU core triggered the segfaults).

* If y-cruncher N32 or HNT tests fail consistently within ~5 seconds each time, you definitely have unstable memory. If it takes longer to fail (60-120 seconds), and specific cores fail more frequently than others, you probably have an unstable memory controller (IMC/SoC). Memory controllers tend to scale negatively with additional voltage past a specific point regardless of thermal conditions, and some cannot clock at high frequencies as you might expect.
