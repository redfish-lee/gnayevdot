---
title: "VIM: vim-airline Characters Fix"
date: 2016-01-08T02:03:30+08:00
slug: "linux-vim-airline-characters-fix" 
description: ""
categories: []
tags: ["Vim", "Linux", "Troubleshooting"]
---

### 顯示問題
安裝 [**vim-airline**](https://github.com/bling/vim-airline) 有時候會出現一些特殊字元的顯示問題。

![Bad Characters](/images/2016-01/bad-char.png)


### Sol.
```bash
# Install symbol font & fontconfig
$ wget https://github.com/powerline/powerline/raw/develop/font/PowerlineSymbols.otf
$ wget https://github.com/powerline/powerline/raw/develop/font/10-powerline-symbols.conf

# Move symbol font to a valid (exist) font path.
$ mv PowerlineSymbols.otf ~/.fonts/

# Update font cache 
$ fc-cache -vf ~/.fonts/

# Install the fontconfig file
$ mv 10-powerline-symbols.conf ~/.config/fontconfig/conf.d/
```


#### Reference:
- [Powerline Troubleshooting](https://powerline.readthedocs.org/en/master/installation/linux.html#fonts-installation)








