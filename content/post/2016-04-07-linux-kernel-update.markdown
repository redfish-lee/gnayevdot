---
title: "Update Linux Kernels"
date: 2016-04-07T16:49:48+08:00
slug: "linux-kernel-update"
description: ""
categories: []
tags: ["Linux", "Systems", "Environment", "Tips"]
---

### 記錄 **amd64** 為例
#### Install Kernel `4.4.6`
```bash
$ cd tmp/
$ wget kernel.ubuntu.com/~kernel-ppa/mainline/v4.4.6-wily/linux-headers-4.4.6-040406_4.4.6-040406.201603161231_all.deb
$ wget kernel.ubuntu.com/~kernel-ppa/mainline/v4.4.6-wily/linux-headers-4.4.6-040406-generic_4.4.6-040406.201603161231_amd64.deb
$ wget kernel.ubuntu.com/~kernel-ppa/mainline/v4.4.6-wily/linux-image-4.4.6-040406-generic_4.4.6-040406.201603161231_amd64.deb

# -i stands for install
$ sudo dpkg -i *.deb

```

#### Uninstall `4.4.6`
```bash
$ sudo apt-get remove 'linux-headers-4.4.6*' 'linux-image-4.4.6*'
```

#### Remove (all)
```bash
# Remove old kernels
$ sudo apt-get autoremove --purge
$ sudo purge-old-kernels
```