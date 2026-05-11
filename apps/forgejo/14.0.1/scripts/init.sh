#!/bin/bash
# Generated from official installation evidence:
# - Forgejo image reference: https://codeberg.org/forgejo/-/packages/container/forgejo
# - Forgejo documentation: https://forgejo.org/docs/latest/admin/installation/docker/

[ -f ./.env ] && source ./.env

# renovate: datasource=docker depName=forgejo/forgejo
IMAGE=codeberg.org/forgejo/forgejo:14.0.1

# 创建基础数据目录并确保权限（由宿主机 1000 用户读写）
mkdir -p ./data
chown -R 1000:1000 ./data

if [ "${ROOTLESS}" = "true" ]; then
    IMAGE="${IMAGE}-rootless"
    mkdir -p ./data-rootless/forgejo ./data-rootless/conf
    chown -R 1000:1000 ./data-rootless/forgejo ./data-rootless/conf
fi

echo "IMAGE=${IMAGE}" >> .env
