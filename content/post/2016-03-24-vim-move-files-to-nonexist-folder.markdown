---
title: "VIM: Move Files to Non-exist Folders"
date: 2016-03-24T12:21:05+08:00
slug: "vim-move-files-to-non-exist-folders"
description: ""
categories: []
tags: ["Linux", "Vim", "Tips"]
---

有時候在移動檔案的時候，會把資料移到一個不存在的資料夾，這個時候通常是去建一個目的資料夾再次移過去，

### General
```bash    
$ mkdir -p /path/of/directories/
$ mv files /path/of/directories/
```

### Short one
```bash    
$ mkdir -p /path/of/directories/; mv files $_
```
- `-p` : Create all **intermediate** directories
- `$_` : 表示前一個傳到 shell 的參數，在這裡也就指 `/path/of/directories/`
