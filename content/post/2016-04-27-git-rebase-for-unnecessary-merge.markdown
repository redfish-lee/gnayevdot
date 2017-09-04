---
title: "Git rebase for Unnecessary Merge"
date: 2016-04-27T12:33:33+08:00
slug: "git-rebase-for-unnecessary-merge"
description: ""
categories: []
tags: ["Git", "Tips", "FAQ"]
---

### 前言
在 Open Source 專案的使用，在本地端或是自己 fork 過去的 repository 都有機會要更新至原專案的最新狀態。
所以常常會用 `git pull origin master`，或許對我們來說與本地端沒有 conflicts 就好。但是等到之後要做 PR 的時候就很容易被檢視 git log 是否乾淨。

### Why?
所謂的 `git pull` 其實是 `git fetch` & `git merge` ，也就是說這裡會出現不必要的 merge 。如果只是在本地端測試等等當然沒有問題，但是如果要 PR 回原先的專案，這個 merge commit 就顯得多餘，也會造成 git workflow 顯得雜亂。比較好的做法是：
    
    $ git pull --rebase upstream master
    $ git push origin master -f
    
#### 
- `-f` : force updated, that's because you only rebase the local, but origin doesn't not rebase.

#### References:
- [Git 基礎- 與遠端協同工作](https://git-scm.com/book/zh-tw/v1/Git-%E5%9F%BA%E7%A4%8E-%E8%88%87%E9%81%A0%E7%AB%AF%E5%8D%94%E5%90%8C%E5%B7%A5%E4%BD%9C)