---
html:
  embed_local_images: false
  embed_svg: true
  offline: false
  toc: true

print_background: true
---

# zshScript
整理一些自己用过的的脚本文件,运行环境为mac ， zsh

## 介绍

# remove_duplicates.sh
    删除当前文件夹下所有子文件夹下重复的文件。
    ---如果同时存在a.xx,a(1).xx且两者大小相等，则删除a(1).xx。