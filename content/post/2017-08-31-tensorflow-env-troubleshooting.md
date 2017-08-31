---
title: "Tensorflow env Troubleshooting"
date: 2017-08-31T07:34:02+08:00
description: ""
categories: []
tags: ["Tensorflow", "Troubleshooting"]
---

## Export Environment Variables
- In `.bashrc`

```bash
$CUDA_HOME = /usr/local/cuda-8.0
export PATH=$CUDA_HOME/bin:$PATH
export LD_LIBRARY_PATH=$CUDA_HOME/lib64:$LD_LIBRARY_PATH
export LD_LIBRARY_PATH=/usr/local/cuda/extras/CUPTI/lib64:$LD_LIBRARY_PATH
export CPPFLAGS='-I$CUDA_HOME/include'
export LDFLAGS='-L$CUDA_HOME/lib64/ -lcudnn'
export LD_LIBRARY_PATH=/opt/intel/mkl/lib/intel64:$LD_LIBRARY_PATH
```
### Update `LD_LIBRARY_PATH`
- After install `libcupti-dev`, add `cuda/extras/CUPTI/lib64`.
- If you build tensorflow source through Bazel MKL options, then `/opt/intel/mkl/lib/intel64` should be added.
- `/usr/local/cuda` is soft-linked to `/usr/local/cuda.8.0`


## TensorFlow Output Log Control
Sometimes we've got messages like this and it's kind of annoying to see the pure outputs at the first sight. So how to avoid these redudant messages?
```bash
I tensorflow/core/common_runtime/local_device.cc:25] Local device intra op parallelism threads: 48
Graphics Device pciBusID 0000:02:00.0
Free memory: 11.75GiB
...
```
- Refer to [`log level commit`](https://github.com/tensorflow/tensorflow/commit/0ed66eb560957987901eef40dcf8e74247841528)
- `export TF_CPP_MIN_LOG_LEVEL=2` for temporary variable in this shell, or
- `echo "export TF_CPP_MIN_LOG_LEVEL=2" >> .bashrc` for default settings
- Or, you can just include in some `.py` files:

```python
import os
os.environ['TF_CPP_MIN_LOG_LEVEL']='2'
import tensorflow as tf
```

### Log Level
```c
min_log_level == "0"    // Maps to INFO (the default).
min_log_level == "1"    // Maps to WARNING
min_log_level == "2"    // Maps to ERROR
min_log_level == "3"    // Maps to FATAL
```
