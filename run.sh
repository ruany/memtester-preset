#!/bin/bash
set -eux

FAIL_MARKER="/tmp/memtest_fail"

fail() {
    echo "********* FAIL *********"
    touch "$FAIL_MARKER"
    notify-send -t 99999999 "MEMORY TEST FAILED!!"
    sleep infinity
}

fail_check() {
    if [ -e "$FAIL_MARKER" ]; then
        echo "Fail marker is present ($FAIL_MARKER), aborting."; exit 1
    fi
}

test_tCL_Hammer() {
    # Test only Bit Flip and Walking Zeroes
    for i in {1..20}; do
        fail_check
        echo "Pass $i:"
        #sudo memtester 400M 1 || fail
        rand=$(shuf -i0-1 -n1)
        if [ $rand = 0 ]; then
            MEMTESTER_TEST_MASK=4097
        else
            MEMTESTER_TEST_MASK=16385
        fi
        sudo MEMTESTER_TEST_MASK="$MEMTESTER_TEST_MASK" memtester 600M 1 || fail
    done
}

# Masks:
# 1024: Checkerboard
# 2048: Bit Spread
# 4096: Bit Flip
# 16384: Walking Zeroes
# 32768: 8-bit Writes
# 65536: 16-bit Writes
test_all() {
    for i in {1..6}; do
        fail_check
        echo "Pass $i:"
        #sudo memtester 1G 1 || fail
        sudo memtester 2G 1 || fail
        #sudo memtester 400M 1 || fail
        #sudo memtester 256M 1 || fail
    done
}

date
test_tCL_Hammer
date
sleep infinity
