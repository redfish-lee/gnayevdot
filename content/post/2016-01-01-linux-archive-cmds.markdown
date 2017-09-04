---
title: "Linux Archive Commands"
date: 2016-01-01T02:03:30+08:00
slug: "linux-archive-cmds" 
description: ""
categories: []
tags: ["Computers", "Linux", "Tips"]
---

### Keyword
- `-c` for compression
- `-x` for extract

### .tar(Package only, no compression)
```bash
$ tar cvf filename.tar Dir_name
$ tar xvf filename.tar Dir_name
```

### .tar.bz2 & .tar.gz
```bash
$ tar zcvf filename.tar.gz Dir_name
$ tar zxvf filename.tar.gz
```

### .zip
```bash
$ zip filename.zip Dir_Name
$ unzip filename.zip
```
