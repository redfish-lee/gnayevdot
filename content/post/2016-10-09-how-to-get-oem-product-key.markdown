---
title: "How to get OEM-Notebook Product Key"
date: 2016-10-09T12:21:05+08:00
slug: "how-to-get-oem-product-key"
description: ""
categories: []
tags: ["Computers", "Systems", "Windows", "FAQ"]
---

## 前言
在 Windows 8 之後配置的筆電，基本上都是採用 OEM 安裝作業系統，也因此不再隨機附送還原光碟及序號。因此如果有換過硬碟，或是自己重灌過後，要再取得原廠預設系統環境，就只能找原廠商重灌取得正版權限。而以華碩皇家為例基本上就是500元工作費，明明有授權，卻被迫要讓別人幫你重灌🙄

### 取得 OEM 序號
#### Step 1. Use [RW-Everything](http://rweverything.com/download/) 
讀取 BIOS 上的序號：ACPI Table → MSDM

![OEM-1](/images/2016-10/oem-key-01.png)
 	
#### Step 2. Windows Assessment and Deployment Kit
安裝 VMAT (Volume Activation Management Tool)，輸入取得的序號所對應的原始 Windows 版本。`WIN 8 RTM Core OEM...`。
因為 OEM 版本還有分很多包括地區等等，所以確認之後就可以在 Windows 官網下載對應的版本安裝了

![OEM-2](/images/2016-10/oem-key-02.png)

#### 注意
    Product key 本身在安裝過程中是無法認證的，要到安裝完後手動認證會透過網路進行確認。

#### Update
遇過有些版本的系統在重灌的時候會自己抓 BIOS 序號做認證，不確定是否與各家廠商設定有關。