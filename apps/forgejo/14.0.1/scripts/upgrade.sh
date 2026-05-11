#!/bin/bash

# 加载当前环境变量
[ -f ./.env ] && source ./.env

# 确保数据目录存在并拥有正确权限，防止升级过程中因权限问题导致 SQLite 无法写入
if [ -d "./data" ]; then
    chown -R 1000:1000 ./data
fi

# 执行通用的初始化逻辑（更新镜像名、处理 Rootless 目录等）
if [ -f ./scripts/init.sh ]; then
    bash ./scripts/init.sh
fi

echo "Upgrade script executed successfully for SQLite mode."
