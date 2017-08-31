---
title: "Tensorflow Preinstall: Drivers, cuDNN, CUDA"
date: 2017-08-23T01:36:43+08:00
description: ""
categories: []
tags: ["Tensorflow", "Install"]
---
### Preinstall
Some packages for builds & dependencies
```bash
sudo apt-get update
sudo apt-get upgrade
sudo apt-get install -y build-essential git unzip wget
    libcurl3-dev libcupti-dev python-dev python3-dev python-pip python3-pip \
    python-pydot python-numpy python3-numpy python-six python3-six \
    python-virtualenv python-wheel python3-wheel python-matplotlib \
    python-pandas python-sklearn  openjdk-8-jdk libfreetype6-dev libxft-dev \
    libncurses-dev libopenblas-dev libblas-dev liblapack-dev \
    libatlas-base-dev gfortran swig \
    linux-headers-generic linux-image-extra-virtual \
    pkg-config zip g++ zlib1g-dev libcurl3-dev
sudo pip install -U pip
```
### Install Nvidia Drivers
1. PPA

```bash
sudo add-apt-repository ppa:graphics-drivers/ppa
sudo apt update
```
2. apt-get

```bash
sudo apt-get install nvidia-375
```
3. Check the result using `nvidia-smi`



### Install Nvidia Toolkit 8.0
There're many different ways like local/network install
```bash
# CHECK YOUR LATEST VERSION
wget https://developer.nvidia.com/compute/cuda/8.0/Prod2/local_installers/cuda-repo-ubuntu1604-8-0-local-ga2_8.0.61-1_amd64-deb

sudo dpkg -i cuda-repo-ubuntu1604-8-0-local-ga2_8.0.61-1_amd64.deb
rm cuda-repo-ubuntu1604-8-0-local-ga2_8.0.61-1_amd64.deb
sudo apt-get update
sudo apt-get install -y cuda
```
This will install cuda into: `/usr/local/cuda`
#### cuda, cuda-8.0
```bash
redfish@lsab:~$ ll /usr/local | grep cuda
lrwxrwxrwx  1 root root    8 Aug 22 23:20 cuda -> cuda-8.0/
drwxr-xr-x 14 root root 4096 Aug 22 23:20 cuda-8.0/
```
- As you can see, the `CUDA Toolkit` default folder is set to `/usr/local/cuda-8.0`
- The `/usr/local/cuda` **symbolic link** points to the location where the CUDA Toolkit was installed.
- This link allows projects to use the latest CUDA Toolkit without any configuration file update.

#### Environment Variables
- `export CUDA_HOME=/usr/local/cuda-8.0/`
- `export PATH=$PATH:$CUDA_HOME/bin$`
- `export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:$CUDA_HOME/lib`

### Install cuDNN
- Not sure if r1.2 TensorFlow support cuDNN 6.0 or later, so cuDNN v5.1 is totally safe.
- Download cuDNN Library for Linux: `cudnn-8.0-linux-x64-v5.1.tgz`
- extract into `/usr/local/cuda` via:

```bash
sudo tar -xzvf cudnn-8.0-linux-x64-v5.1.tgz
cuda/include/cudnn.h
cuda/lib64/libcudnn.so
cuda/lib64/libcudnn.so.5
cuda/lib64/libcudnn.so.5.1.10
cuda/lib64/libcudnn_static.a
```
```bash
sudo cp cuda/include/cudnn.h /usr/local/cuda/include
sudo cp cuda/lib64/libcudnn* /usr/local/cuda/lib64
sudo chmod a+r /usr/local/cuda/include/cudnn.h /usr/local/cuda/lib64/libcudnn*
```
#### NVIDIA CUDA Profile Tools Interface
- `sudo apt-get install libcupti-dev`
- `export LD_LIBRARY_PATH="$LD_LIBRARY_PATH:/usr/local/cuda/extras/CUPTI/lib64"`

##### References
- [nvidia-install-doc](http://docs.nvidia.com/cuda/cuda-installation-guide-linux/index.html)
- [Install Tensorflow from src](https://alliseesolutions.wordpress.com/2016/09/08/install-gpu-tensorflow-from-sources-w-ubuntu-16-04-and-cuda-8-0/)
- [Installing tensorflow on aws GPU instance](http://expressionflow.com/2016/10/09/installing-tensorflow-on-an-aws-ec2-p2-gpu-instance/)
- [cuDNN install guide](http://developer2.download.nvidia.com/compute/machine-learning/cudnn/secure/v5.1/prod/doc/cudnn_install.txt?orCYTNdBxYW2yOYvYwfFamN5juy4rrtFs6NS-8fLWfJsF18n8HkQ0MJcgVPZQW8zSY5y5Iw5Kyb9lA8RduC8iGMCT6G7liwgpgvW3KmoIxllldADxI-FsZeCs1xr8POXyQAZAU3HkSfJZJfa1NJz_bg9FT03dYYCuOQDrqbBuQX20zd2)
