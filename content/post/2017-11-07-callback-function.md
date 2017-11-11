---
title: "Callback function scenario"
date: 2017-11-07T19:18:58+08:00
slug: "callback-function-scenario"
description: ""
categories: []
tags: ["Programming", "Tips"]
---

### Callback Function
顧名思義就是回去呼叫某個函式執行，至於什麼時候回去呼叫？如何知道呼叫哪個函式？
#### Sequential function call the function directly
```c
int compute() {
    // Do something
}
void main() {
    int result = compute();
    printf("compute result: %d", result);
}
```
#### Callback function is event-driven
當特定事件發生時(例如觸控發生，或某手勢被偵測)才會被呼叫：

- **Step 1:** Register the callback function (function pointer and function args as parameters).
- **Step 2:** Wait to be called.

### 舉個例子
```
Secnario: 如果有 A, B 兩個 programs，希望某個 event 發生的時候 B 可以通知 A
Solution: A 必須傳一個 function pointer 給 B 當 event 發生的時候要執行什麼
```

### 實務上的例子
a Unix program might not want to terminate immediately when it receives SIGTERM, so to make sure that its termination is handled properly, it would register the cleanup function as a callback.
```c
// Nachos source code
void CallOnUserAbort(void (*func)(int)) {
    (void)signal(SIGTERM, func);
}
static void Cleanup(int x) {
    cerr << "Cleaning up after signal " << x << "\n";
    delete kernel;
}
int main() {
    kernel = new Kernel(argc, argv);
    kernel->Initialize();
    
    // if user hits Ctrl-C, delete kernel
    CallOnUserAbort(Cleanup);
    kernel->ExecAll();
}
```
