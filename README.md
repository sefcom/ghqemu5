# ghqemu5

## OVERVIEW

Implements the following mitigations:
- hackdev/proc: copies contents of /dev and /proc, hacks openat() syscalls to read from there
- hackbind: forces ipv6 binds to 0.0.0.0 on ipv4 (deconflicts any overlapping ports via increment)
- execve: adds an argument that specifies the absolute path to the qemu-user-static binary, used to workaround `system()` and `execve()` calls so they use the same qemu-user-static binary with the same arguments passed in (otherwise, it defaults to the host machine's QEMU, which can cause issues even with binfmt-tools installed)
- -hacksys: workaround that always indicates that 0 cpu resources are in use, to get around behavioral changes due to sys limits, especially when fuzzing

Also adds various changes to the QEMU trace/logging process for better usage with Greenhouse

## qemu5 vs qemu6

We are currently in the process of migrating to qemu6. The original runs well with qemu5, the code in qemu5 is up to date as of oct6 2022.

The qemu6 version contains the latest version of qemu development and has the patches for Greenhouse rehosting applied. There are some bugs that occur when rehosting certain samples that appear to be due to changes in qemu itself (from qemu5 to qemu6). It is currently included for completeness.

# BUILDING

(Based on http://logan.tw/posts/2018/02/18/build-qemu-user-static-from-source-code/)

`cd qemu5`

`./configure --prefix=$(cd ..; pwd)/qemu-user-static --static --disable-system --enable-linux-user`

`make -j8`

`make install`

`cd ../qemu-user-static/bin`

`for i in *; do mv $i $i-static; done`

# RELEVANT FOLDERS

Touched files:
- accel/tcg/cpu-exec.c
- include/qemu/log.h
- linux-user/main.c
- linux-user/syscall.c
