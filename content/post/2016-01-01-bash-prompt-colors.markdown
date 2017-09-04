---
title: "Personalize Bash Prompt Colors"
date: 2016-01-01T02:03:30+08:00
slug: "linux-bash-prompt-colors" 
description: ""
categories: []
tags: ["Linux", "Shell", "Tips"]
---

#### **.bashrc**
`.bashrc` 是存放 bash shell 的設定檔，除了一些路徑變數以外，還可以自訂 terminal 載入時名稱等等的顯示方式。

#### Color-set Escape Seq.
```bash
PS1='\[\e[0;32m\]\u\[\e[m\] \[\e[1;34m\]\w\[\e[m\] \[\e[1;32m\]\$\[\e[m\] \[\e[1;37m\]'
```
- `\[\e[color_encode\]`: Start coloring
- `\[\e[m\]`: End coloring

#### Placeholders
- `\u` for the username. 
- `\h` for the hostname.
- `\w` for current **absolute path**.
- `\W` for current **relative path**.
- `\$` for the prompt character (eg. `#` for root, `$` for regular users).

#### Color Table:

    '\e[0;30m' # Black - Regular
    '\e[0;31m' # Red
    '\e[0;32m' # Green
    '\e[0;33m' # Yellow
    '\e[0;34m' # Blue
    '\e[0;35m' # Purple
    '\e[0;36m' # Cyan
    '\e[0;37m' # White
    0 for normal; 1 for bold

<p align="center">
  <img src="/images/2016-01/prompt.jpg"/>
</p>

#### Reference:
- [arch color promt](https://wiki.archlinux.org/index.php/Color_Bash_Prompt)
