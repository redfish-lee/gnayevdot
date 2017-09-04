---
title: "Build Specfic Version of Packages"
date: 2016-04-06T05:54:33+08:00
slug: "build-specific-version-of-packages"
description: ""
categories: []
tags: ["Linux", "Environment", "Tips"]
---
### 情形
有時候會遇到在編譯或是建置環境的時候要求某些套件的版本要在幾版之後，但如果有以下環境會滿有機會遇到的：
- Ubuntu LTS 版本：可能是2, 3年前的 LTS 版本，當初版本比較舊
- Debian Distro：最穩定但套件也最舊
- Newer packages：新版的套件還有尚未修正的ISSUES而且會影響到使用（或是 Compatible 問題）
此時就必須知道對套件要安裝到哪個版本，去 source repo 下載並手動安裝

### 以 make 為例
#### 當環境要求要達到 `Make Version: 4.0 or later`
- 如果用 `apt-get update` 完，`make --version` 仍不到要求
- 表示你的 Ubuntu Distro 當初的 make 版本就不夠，就算update 也只是更新舊版本而已。


#### 步驟
```bash
# Download specific version source code
$ cd /tmp
$ wget http://ftp.gnu.org/gnu/make/make-4.1.tar.gz
$ tar xvf make-4.1.tar.gz


# Manually Install
$ ./configure
$ make
$ sudo make install
$ rm -rf make-4.1.tar.gz make-4.1
```

- 測試新版本是否安裝完成 `make --version`
- 若不確定 make (bin) 是哪一個可以用 `which make` 查看
- 確定 `$PATH` 是否含有所在路徑 `/usr/local/bin`

### 後記
整理的時候發現在是在基本不過的環境建置過程，看看當初第一次遇到這種情形搞了好久，也算是有一點點點進步啦🤔