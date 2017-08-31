---
title: "Open Remote Jupyter Notebook in Localhost"
date: 2017-08-23T10:36:26+08:00
description: ""
categories: []
tags: ["Python", "Jupyter", "Tools", "Remote"]
---

## How to use Jupyter Notebook from remote server locally
Jupyter Notebook 是很好用的 python 即時編輯工具，可以直接在 `.ipynb` 上編輯並輸出結果，也可以改動程式碼更新不一樣的結果，是很方便的工具。
而 `jupyter notebook` 一般是在 `localhost:8888` 開啟，但是要直接連到 static IP 的 port 有防火牆的問題，也不是安全的方法。

```bash
[redfish@localhost]$ jupyter notebook
[I 08:21:06.179 NotebookApp] Serving notebooks from local directory: /Users/redfish
[I 08:21:06.180 NotebookApp] 0 active kernels
[I 08:21:06.180 NotebookApp] The Jupyter Notebook is running at: http://localhost:8888/?token=f526a81e27d5348333cbe55152a8e524da7137dafais14ae
```
![Alt text](/images/2017-08-23-remote-jupyter-notebook/8888.png)

## Setup Using [ngrok](https://ngrok.com/)
### Install
```bash
# MacOS
brew cask install ngrok

# Linux 64-bit
wget https://bin.equinox.io/c/4VmDzA7iaHb/ngrok-stable-linux-amd64.zip
unzip ngrok-stable-linux-amd64.zip
./ngrok help
```
### Set Alias `.bashrc`
```bash
alias ngrok='$HOME/.local/bin/ngrok'
export PATH="$PATH:/usr/bin:/usr/local/bin"
```

### @remote
```bash
[redfish@remote]$ jupyter notebook
...
# The localhost here is remote machine
http://localhost:8888/?token=f526a81e27d5348333cbe55152a8e524da7137dafais14ae
```
```bash
# Open a security connection to public with port 8888
[redfish@remote]$ ngrok http 8888
```
### @localhost
打開瀏覽器開啟網頁即可連線到 remote 端的 port ，如果有在測試網頁的就不用另外再開一個網站測試就可以公開或是讓特定對象存取。
記得要輸入 token。
![Alt text](/images/2017-08-23-remote-jupyter-notebook/token.png)

### Advanced Authentication
```bash
# More secure method using account to access
[redfish@remote]$ ngrok http -auth="username:password" 8888
```
![Alt text](/images/2017-08-23-remote-jupyter-notebook/auth.png)
