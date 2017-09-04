---
title: "Screen Brightness Adjustments in Linux"
date: 2016-04-20T02:34:37+08:00
slug: "linux-screen-brightness" 
description: ""
categories: []
tags: ["Computers", "Linux", "LXDE", "Tools"]
---

有些 Linux Distributions 內建就有 GUI Settings 可以調整，在這裡是在 LXDE 遇到的情形，我們可以用 `xbacklight` package 來設定：
```bash
$ sudo apt-get install xbacklight
$ xbacklight -set 40
```
-  `40` is the scale compared to this level