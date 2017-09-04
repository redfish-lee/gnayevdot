---
title: "KiB & KB differences: Speed & Bandwidth"
date: 2016-12-21T21:07:48+08:00
description: ""
slug: "diff-kib-and-kb"
categories: []
tags: ["Computers", "Hardwares", "FAQ"]
---

#  前言
在大部分人包括我的印象就是 KB = Kb，1000 ≒ 1024。
這在絕大多數的情形下是沒有太大的影響。但如果今天跟速度扯上一點關係的話，這個差異就十分明顯了。

##  `K`, `Ki`
| **`K(1000)`**       | **`Ki(1024)`**       |
|---------------------|----------------------|
| `1 KB = 1,000 Byte` | `1 KiB = 1,024 Byte` |
| `1 MB = 1,000 KB`   | `1 MiB = 1,024 KiB`  |
| **`Giga`**`byte`    | **`Gibi`**`byte, giga`**`BINARY`**`byte`|

## `B(yte)`, `b(it)`
- `1 Byte = 8 bit`
- `Byte` is Uppercase
- `bit` is Lowercase

## 在硬碟中的差異 Differences in disk
### Disk Manufacturer
一般市售硬碟都是以 1000 為單位，例如：
`500GB = 500,000 MB`, for `1KB = 1000Byte`

### Operating Systems
- Mac OS: `500GB = 500,000 MB`
- Windows PC: `500,000 MB / 1024 MiB = 488.28125 GB`

### Bandwidth, r/w Speed

|                   | Bandwidth    | Speed         |
|-------------------|--------------|---------------|
| SATA 3            | 6 Gbps       | 600 MB/s      |
| Unit              | Gigabits/sec | Megabytes/sec |

##### 為何轉換後速度並沒有與頻寬一致？
理論上，`6 Gigabits = 6Gbps / (8bit/1byte) = 750MB/s`，為何與存取速度卻只有 `600MB/s` ?

因為每 10 位編碼中只有 8 位元是真實資料，也就是 [8b/10b Encoding](https://en.wikipedia.org/wiki/8b/10b_encoding)

所以 `750MB/s * 0.8 = 600MB/s` 才是實際的存取速度。

##### 參考資料
- [Wiki/Gibibyte](https://en.wikipedia.org/wiki/Gigabyte)

![table](/images/2016-12/table.png)
