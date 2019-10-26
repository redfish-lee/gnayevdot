---
title: "Pointer Aliasing and Strict Aliasing Rule"
date: 2019-10-27T01:25:28+08:00
description: ""
categories: []
tags: ["C/C++"]
---

# Pointer Aliasing

在 C++ 中，多個 pointeres 指向同個記憶體位置，我們稱為 **Pointer Aliasing**

- 此時兩個 pointer 的權限都一樣，可以修改甚至刪除空間
- 但是若其中一個 pointer 被 delete 後，可能會造成其他 pointers 成為 **Dangling Pointer**
- 因為 aliasing 的錯誤使用很可能無法在 compile time 發現，可能會造成輸出的結果錯誤
- ex., ***undefine behavior***，像是用 double pointer 去 deference 一個 int

```c++
    int *pA = new int(4);   // new a space
    int *pB = pA;           // Both of them store same address
    
    *pB = 10;               // Alias pointer can also make modification
    cout << *pA << endl;    // 10
    delete pA;
    
    cout << *pB << endl;    // xx
```

### Dangling Pointer
```c++
    int *pA = nullptr;
    {
    	int n = 20;
    	pA = &n;
    	cout << *pA << endl;   // 20
    }
    
    // pA becomes a dangling pointer
    cout << *pA << endl;       // xx
```
## Example

一個說明 aliasing 如何影響 compiler 優化的例子：
```c++
    // Case 1 
    void foo(int *a, int *b, int *res) {
    	for (int i = 0; i < 10; i++) {
    		*res += *a + *b;
    	}
    }
    
    // Case 2
    // Compiler tends to do so..
    // to load *a and *b only once instead of each iteration
    void foo(int *a, int *b, int *res) {
    	int temp = *a + *b;
    	for (int i = 0; i < 10; i++) {
    		*res += temp;
    	}
    }
    
    // 事實上，Compiler 會預設可能有 pointer aliasing，所以不會執行這種優化
    // 因為下面這個例子，在每個 iteration 都會改變 val 的值，所以無法提到迴圈外
    foo(&val, &val, &val);

    // Case 1 
    void foo(int *a, int *b, int *res) {
    	for (int i = 0; i < 10; i++) {
    		*res += *a + *b;
    	}
    }
    
    // Case 2
    // Compiler tends to do so..
    // to load *a and *b only once instead of each iteration
    void foo(int *a, int *b, int *res) {
    	int temp = *a + *b;
    	for (int i = 0; i < 10; i++) {
    		*res += temp;
    	}
    }
    
    // However, if we called, results of case 1 and 2 differs.
    foo(&val, &val, &val);
    
    // 因為 a, b, res 都是 aliasing, 所以每個 iteration 後，值都會改變
```

- `restrict` 可以用來表示某個 pointer 沒有 aliasing，由 programmer 自行決定
- **Strick Aliasing 並無法改變 `foo()` 能否套用優化**

# Strict Aliasing Rules

**strict aliasing rule 有一些假定且預設 programmer 會遵守，compiler 才可以套用更多優化**

- `-O2` 之後的 compilation level 預設執行 strict aliasing rule
- 這也是為什麼有時候 `-O1` 與 `-O2` 的執行結果有可能不同 (ex., )

```c++
    // cast result differs in different levels of compilation
    double d = 3.4;
    unsigned int *p = (unsigned int *)(&d);
```

- `CFLAGS=-fno-strict-aliasing` 可以取消 strict aliasing rule
- 不允許建立與原先型別不同的 alias，ex., 用 double pointer 去存取 int

> *Dereferencing a cast of a variable from one type of pointer to a different type is usually in violation of the strict aliasing rule.*

## Assumptions that Strict Aliasing is enabled

- Compiler 會假定不同型別的 `int *foo` 與 `double *bar` 一定不會 refer 到同個位址
- 如此 programmer 就要負責避免可能產生不同型別的 alias (ex., 亂作 casing)
- **這個設計主要的目的是擴展優化在在某些情境下可以執行**，而不是消極認定 aliasing 的可能性

```c++
    void foo(int *a, int *b, long *res) {
    	int temp = *a + *b;
    	for (int i = 0; i < 10; i++) {
    		*res += temp;
    	}
    }
    
    // strict aliasing warning
    // long *res can't be alias of int* a, *b
    foo(&val, &val, &val);  
```

# References

[Pointers in C, Part III: The Strict Aliasing Rule - Approxion](https://www.approxion.com/pointers-c-part-iii-strict-aliasing-rule/)

[What is Strict Aliasing and Why do we Care?](https://gist.github.com/shafik/848ae25ee209f698763cffee272a58f8)

[Understanding Strict Aliasing](https://cellperformance.beyond3d.com/articles/2006/06/understanding-strict-aliasing.html)

[Strict Aliasing](http://dbp-consulting.com/tutorials/StrictAliasing.html)
