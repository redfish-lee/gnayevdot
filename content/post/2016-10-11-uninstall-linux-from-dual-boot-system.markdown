---
title: "Uninstall Linux from Dual-boot System"
date: 2016-10-11T02:03:30+08:00
slug: "uninstall-linux-from-dual-boot-system" 
description: ""
categories: []
tags: ["Computers", "Systems", "Linux", "Windows", "FAQ"]
---
## 前言
安裝過雙系統的使用者都知道，安裝雙系統（Windows + Linux Distributions）比較簡單且安全的方式是先安裝 Windows 系統後在安裝 Linux 系統，詳細過程不再贅述。這次主要紀錄 **如何安全在雙系統中移除 Linux 系統（切割）**。因為這件事情發生不止一次，我決定把它記錄下來：

### Bad Idea
以前單純認為把 Linux ext4 partitions 在 Windows 中刪除，就可以回復到只剩 Winodows 系統。事實是，當再次開機時：

```
grub rescue >
```

為什麼刪除 Linux 系統後竟然連 Windows 都進不去？**關鍵在於一開始雙系統是如何設定開機選單的。**

主開機紀錄（Master Boot Record，MBR），是開機讀取硬碟的第一個 sector。而每個作業系統都有自己的 boot loader，安裝 Linux 後則是常用的 grub/grub2 寫入 MBR，設定開機程式選單引導到不同 FileSystem 的 loader 載入核心。也因此如果直接把 Linux filesystem 刪除，grub 找不到對應正確的 boot loader 位址就會進入 rescue mode。

<p align="center">
  <img src="/images/2016-10/loader.jpg"/>
</p>

但如何用 grub rescue mode 設定 bootloader 指向的位置
可利用 `set (hd0, msdos3)/boot/` 等方式設定回正確的 Windows Boot Loader。細節在此不贅述。

### Preferable Idea

既然都知道這樣刪除要多走 grub rescue 這關，我們可以在移除 Linux 分割區之前，先把預設的 MBR Loader 改成 Windows Bootloader。這時就要用到像是 [EasyBCD](https://neosmart.net/EasyBCD/) 等工具來寫入。

```
每顆硬碟最前面區塊含有 MBR 或 GPT 分割表的提供 loader 的區塊。
至於兩者的差異在於 MBR 只能包含 4 個 primary partition，
所以如果要切更多磁區就要設定成 logical，還有不支援 2TB以上的硬碟等等。
GPT 是比較新的分割表，優劣不贅述，但 UEFI 勢必都要搭配 GPT 服用。
```

### Update
用 UEFI 安裝 Win10 及 Ubuntu 16.04 時，安裝過程就會讀到 Windows 的 Boot Manager 切割區，所以直接安裝完 grub 就設定好了，如果是舊版本用 Legacy 安裝有時候是需要用到 `Boot Repair` 來改動雙系統的選單。
 
#### References
- [loader image](http://linux.vbird.org/linux_basic/0510osloader//loader_menu.gif)
- [VBird 鳥哥的私房菜](http://linux.vbird.org/linux_basic/0510osloader.php)
