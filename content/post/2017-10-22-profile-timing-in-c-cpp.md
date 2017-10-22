---
title: "Profile Timing in C/C++"
date: 2017-10-22T18:52:58+08:00
description: ""
categories: []
tags: ["performance", "c/c++", "profiling"]
---
### Linux built-in `time`
內建指令可以測試程式的執行時間（CPU time）
```bash
time ./a.out

real    0m1.210s
user    0m1.209s
sys     0m0.001s
```
- 會受到 CPU 當時的使用率負載狀況影響
- `real` 實際時間
- `user` user time, user space program time
- `sys` system time, OS kernel space time

### GNU `clock`
```
#include <time.h>

clock_t start, end;
double cpu_time_used;

start = clock();
/* Do the work. */
end = clock();
cpu_time_used = ((double) (end - start)) / CLOCKS_PER_SEC;
```
- `time.h`
- `clock()` 得到 CPU 的時脈數，`CLOCKS_PER_SEC` 是 CPU 每秒的時脈數，相除就是秒數。（CPU 時脈不盡相同）
- [GNU manual](https://www.gnu.org/software/libc/manual/html_node/CPU-Time.html)

### GNU `clock_gettime`
#### timespec object
```
struct timespec {
  time_t tv_sec;  /* seconds */
  long   tv_nsec; /* nanoseconds */
};
```
#### Usage 
```cpp
timespec time1, time2;
clock_gettime(CLOCK_PROCESS_CPUTIME_ID, &time1);
/* Do the work. */
clock_gettime(CLOCK_PROCESS_CPUTIME_ID, &time2);
```

- `time.h`
- 可以得到較精確的時間，而且可以測量單一 thread 的 CPU time
- [GNU manual](https://linux.die.net/man/3/clock_gettime)