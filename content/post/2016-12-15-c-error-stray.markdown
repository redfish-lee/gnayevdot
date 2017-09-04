---
title: "C++ error stray in Program"
date: 2016-12-15T18:30:47+80:00
slug: "c-error-stray-in-program"
description: ""
categories: []
tags: ["C/C++", "Programming", "Troubleshooting"]
---
### Problem
在編譯 C++ 檔案時，compiler error messages : 
```bash
../new:9: error: stray ‘\200’ in program
../new:9: error: stray ‘\237’ in program
../new:9: error: stray ‘\346’ in program
../new:9: error: stray ‘\265’ in program
```

### Solved
主要原因是在程式碼裡，可能包含 **`Unicode`** 的字元，而程式碼預設是用 **`en(ascii)`** 編譯。

- 移除 unicode characters
- 設定系統參數：`env LANG=en_US.UTF-8`