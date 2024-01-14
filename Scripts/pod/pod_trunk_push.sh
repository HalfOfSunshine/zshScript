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

# 取出current_spec的文件内容
spec_content=$(cat $(pwd)/$current_spec)
echo "当前spec路径：$(pwd)/$current_spec";

# 使用 grep 结合正则表达式匹配版本号字符串，取2-5位。
version_line=$(echo "$spec_content" | grep -E '^\s*s\.version\s*=\s*["'\'']([0-9]+\.[0-9]+(\.[0-9]+){0,3})["'\'']')
echo "version_line:$version_line"
# 取出spec内的版本号作为要发布的版本号
current_pod_version=$(echo "$version_line" | sed -n "s/.*['\"]\([^'\"]*\)['\"].*/\1/p")
echo "版本号为:$current_pod_version"

# 判断是否是 "a.b.c" 的格式
if ! [[ $current_pod_version =~ [0-9]+$ ]]; then
  echo "版本号格式不正确,请检查s.version字段"
  exit 1
fi

echo "\033[31m\033[1m\n重要!!!请确认以下内容："
echo "1、测试接口确保已改成正式接口"
echo "2、mock代码确保已经注释，加解密算法与线上一致"
echo "3、如有依赖库文件变动、适配器增减，确保podspec及SDK文件夹已做相关调整"
echo "4、SDK版本字段及podspec中版本号均已更新\033[0m"

  echo "\033[31m\033[1m\n即将发布版本：$current_spec - $current_pod_version \033[0m"

  read -p "确认执行吗？(y/n): " confirm
  if [ "$confirm" == "y" ]; then
    proxy_on
    if git tag -a $current_pod_version -m "$current_pod_version"; then
        if git push origin $current_pod_version 2>&1 | grep -q "Everything up-to-date"; then
            echo "github 标签 ：tag -$current_pod_version 已经是最新的，继续执行下一步操作"
        else
            echo "推送成功"
        fi
            # echo "即将执行：pod trunk push $current_spec --verbose --allow-warnings"
            pod trunk push $current_spec --verbose --allow-warnings
    else
        error_message=$(git tag -a $current_pod_version -m "$current_pod_version" 2>&1)
        if [[ "$error_message" =~ "already exists" ]]; then
            echo "本地tag -$current_pod_version 标签已存在，继续执行下一步操作"
            
            if git push origin $current_pod_version 2>&1 | grep -q "Everything up-to-date"; then
                echo "github 标签 ：tag -$current_pod_version 已经是最新的，继续执行下一步操作"
            else
                echo "推送成功"
            fi

            # echo "即将执行：pod trunk push $current_spec --verbose --allow-warnings"
            pod trunk push $current_spec --verbose --allow-warnings
        else
            echo "出现其他错误: $error_message"
            exit 1
        fi
    fi
  else
      echo "已取消执行"
  fi