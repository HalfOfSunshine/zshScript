#!/bin/bash

source ~/script/proxy_functions.sh

# shopt -s nullglob 来处理文件名通配符，确保在没有匹配文件时，数组 spec_files 的长度为 0。
shopt -s nullglob
spec_files=(*.podspec)
if [ "${#spec_files[@]}" -le 0 ]; then
  echo "当前文件夹下没有podspec文件，请切换到需要操作的podspec所在文件夹下执行脚本"
  exit 1
fi

if [ "${#spec_files[@]}" -gt 1 ]; then
  echo "当前文件夹下存在多个podspec:"
  for ((i=0; i<"${#spec_files[@]}"; i++))
  do
    echo "$(($i+1)). ${spec_files[i]}"
  done

  # 循环要求用户输入文件
  while true; do
    read -p "请输入需要发布的podspec(1-${#spec_files[@]}): " user_input
    #  # (默认为列表第一个) 
# if [ -z "$user_input" ]
# then
#     user_input=1
#     current_spec="${spec_files[$((user_input-1))]}"
#     echo "已选择文件: $current_spec"
#     break
# fi
    # 检查输入是否在有效范围内
    if [[ "$user_input" =~ ^[1-${#spec_files[@]}]$ ]]; then
      # 输入合法，赋值给current_spec
      current_spec="${spec_files[$((user_input-1))]}"
      # echo "已选择文件: $current_spec"
      break
    else
      echo "无效输入，请重新输入."
    fi
  done
else
  current_spec="${spec_files[0]}"
fi

# 使用 basename 获取文件名（去掉路径）
file_name=$(basename "$current_spec")
# 去掉 .podspec 扩展名
spec_name="${file_name%.podspec}"

if [[ -n $1 ]]
then
    delete_version=$1
else
   read -p "请输入$spec_name 要删除的版本号: " delete_version
fi

echo "即将删除$current_spec 版本：-$delete_version"
  read -p "确认执行吗？(y/n): " confirm
  if [ "$confirm" == "y" ]; then
    proxy_on
    if git tag -d $delete_version; then
        if git push origin --delete $delete_version 2>&1 | grep -q "remote ref does not exist"; then
                echo "github 标签 ：tag -$delete_version 不存在，继续执行下一步操作"
        else
            echo "推送成功"
        fi
            # echo "即将执行：pod trunk delete $spec_name $delete_version"
             pod trunk delete $spec_name $delete_version
    else
        error_message=$(git tag -d $delete_version 2>&1)
        if [[ "$error_message" =~ "not found" ]]; then
            echo "本地tag -$delete_version 标签不存在，继续执行下一步操作"
            
            if git push origin --delete $delete_version 2>&1 | grep -q "remote ref does not exist"; then
                echo "github 标签 ：tag -$delete_version 不存在，继续执行下一步操作"
            else
                echo "推送成功"
            fi

            # echo "即将执行：pod trunk delete $spec_name $delete_version"
            pod trunk delete $spec_name $delete_version
        else
            echo "出现其他错误: $error_message"
            exit 1
        fi
    fi
  else
      echo "用户取消执行"
  fi