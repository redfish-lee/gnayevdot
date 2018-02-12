---
title: "Thread Safety Annotations for Clang"
date: 2018-02-13T01:11:11+08:00
slug: "thread-safety-for-clang"
description: ""
categories: []
tags: ["threads", "talk", "tracing"]
---

## 前言
在 trace [code](https://github.com/tensorflow/tensorflow/blob/e062447136faa0a3513e3b0690598fee5c16a5db/tensorflow/core/distributed\_runtime/worker\_session.cc#L85
) 時發現 `GUARDED_BY (mu_)` 的寫法，所以用這個 talk 的內容做簡單的介紹：

- Lecturer: [DeLesley Hutchins](mailto:delesley@google.com)
- Lecture slide: [pdf](https://llvm.org/devmtg/2011-11/Hutchins_ThreadSafety.pdf)
- Lecture video: [YouTube](https://www.youtube.com/watch?v=5Xx0zktqSs4)

## Why we need thread safety annotations ?
多執行緒程式大多圍繞著 race condition (資源競爭)，但這些情形在 source code 中很難看出來，因為：

- 資源競爭是與其他執行緒交互影響的結果
- 在本地的程式碼中未必可見
- 未必是 code review 著重的項目

除此之外，也很難消除 race condition，因為：

- 在 unit tests 過程中未必找得出來
- Bugs are intermittent (斷斷續續週期性)

### Real World Example
下面是一個 cache class，當我們初次查找 `lookup` 一個 key 並得到對應 value 時，該 key-value pair 會被 **pinned** 到 cache 上，直到這個 pair 被 release
```c
// a global shared cache 
class Cache { 
  public:
    // find value, and pin within cache 
    Value* lookup(Key *K); 
    
    // allow value to be reclaimed 
    void release(Key *K);
};

Mutex CacheMutex;
Cache GlobalCache;
```

下面是 Cache Helper Class，用來處理 cache 的 **pinning / un-pinning**

- `pinning` in constructor
- `release` in destructor

```cpp
// Automatically release key when variable leaves scope 
class ScopedLookup { 
public:
  ScopedLookup(Key* K)
    : Ky(K), Val(GlobalCache.lookup(K)) { }
  ~ScopedLookup() {
    GlobalCache.release(Ky);
  }
  Value* getValue() { return Val; } 

private: 
  Key* Ky; 
  Value* Val;
};
```

#### Bug code
```c
void bug(Key* K) {
  CacheMutex.lock();
  ScopedLookup lookupVal(K);
  doSomethingComplicated(lookupVal.getValue());
  CacheMutex.unlock();
  // bad things happen..
};
```
- 遵循 `lock => process => unlock` 規則，在 code review 時不易發現
- 雖然 `unlock` 完成，但是 `release` pinned cache 在 helper destructor 才會真正執行

#### Fix code
```c
void bug(Key* K) { 
  CacheMutex.lock();
  {
    ScopedLookup lookupVal(K);
    doSomethingComplicated(lookupVal.getValue());
    // force destructor to be called here...
  }
  CacheMutex.unlock();
};
```
- `{...}` 是一個 local scope，離開後變數會消失(呼叫destructor)

#### Fix with annotations
但如何自動找到這些潛藏的 race condition？**建立註解！**

- `cache` is guarded by `mutex`
- 確保持有 `mutex` 才能夠執行，須額外加上 `EXCLUSIVE_LOCKS_REQUIRED(CacheMutex)`

```c 
Mutex CacheMutex;
Cache GlobalCache GUARDED_BY(CacheMutex); 

class ScopedLookup { 
public:
  ScopedLookup(Key* K) EXCLUSIVE_LOCKS_REQUIRED(CacheMutex)
    : Ky(K), Val(GlobalCache.lookup(K)) {}

  ~ScopedLookup() EXCLUSIVE_LOCKS_REQUIRED(CacheMutex) {
    GlobalCache.release(Ky);
  } 
  ...
};
```
有了這些註解，編譯器就會在編譯時給出可能造成 race condition 的 warnings

```c
void bug(Key* K) {  
  CacheMutex.lock();  
  ScopedLookup lookupVal(K);
  doSomethingComplicated(lookupVal.getValue());
  CacheMutex.unlock();
  // Warning: ~ScopedLookup requires lock CacheMutex 
};
```

## What the annotations are, and what they do ?
- 這些 annotation 會違反一些 `gcc` 的 coding guidline，後來轉移到 `clang`
- 偏向 `type checking` (declare b4 use)，在 `compile time` 時檢查，多為 common errors

## Feedback
- 在 trace code 時看到的寫法，在這次講解中釐清
- `TensorFlow` 等專案都有採用此寫法
- 原著講解中還有包括 annotation parsing 等等可以參考