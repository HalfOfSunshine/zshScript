#!/bin/bash
#删除所有重复的文件,同时存在a.xx,a(1).xx且两者大小相等，删除a(1).xx
# 遍历当前文件夹及所有子文件夹
find . -type f -exec bash -c '
  echo "删除重复文件"

  for file do
    base_file="${file%.*}"
    ext="${file##*.}"
    duplicate_file="${base_file}(1).${ext}"
    echo "当前文件:$base_file"

    if [ -e "$duplicate_file" ]; then
      size_file=$(stat -f %z "$file")
      size_duplicate=$(stat -f %z "$duplicate_file")

      if [ "$size_file" -eq "$size_duplicate" ]; then
        echo "删除重复文件: $duplicate_file"
        rm "$duplicate_file"
      fi
    fi
  done
' bash {} +
