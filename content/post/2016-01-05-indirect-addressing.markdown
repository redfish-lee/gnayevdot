---
title: "Indirect Addressing in Computer Architechture"
date: 2016-01-05T12:21:05+08:00
slug: "computer-indirect-addressing"
description: ""
categories: []
tags: ["Computers", "Systems", "Hardwares"]
---

### Defn
**Indirect Addressing:**

_The address of the data is held in an intermediate location so that the address is first 'looked up' and then used to locate the data itself._

也就是說，要知道目標資料到底放在哪，要先去一個地址找到目標地址的實際地址在哪，有點像是郵政信箱。

<p align="center">
  <img src="/images/2016-01/indirect-addressing.png"/>
</p>

### Details
**1)** A specific block of memory will be used by the loader to store the starting address of every subroutine within the library. This block of memory is called a `vector table`. A vector table holds addresses rather than data. The application is informed by the loader of the location of the vector table itself.

**2)** In order for the CPU to get to the data, the code first of all fetches the content at RAM location 5002 which is part of the vector table.

	
**3)** The data it contains is then used as the address of the data to be fetched, in this case the data is at location `9000`


A typical assembly language instruction would look like:
```
MOV A, @5002
# Look at location 5002 for the address which points to the target data.
# That address is then used to fetch data and load it into the accumulator.
# In this case: 302
```

#### Reference:
- [teach-ict](http://www.teach-ict.com/as_as_computing/ocr/H447/F453/3_3_8/lowlevel/miniweb/pg4.htm)
