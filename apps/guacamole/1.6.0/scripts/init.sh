#!/bin/bash
# Generated from official installation evidence:
# - Apache Guacamole Docker docs: https://guacamole.apache.org/doc/gug/guacamole-docker.html
# - Guacamole requires an external MySQL or MariaDB service and schema initialization before first start.

ENV_FILE="./.env"

if [[ ! -f "$ENV_FILE" ]]; then
  echo ".env 文件不存在"
  exit 1
fi

if grep -q "^PANEL_DB_TYPE=['\"]mariadb['\"]" "$ENV_FILE"; then
  echo "当前选择的是 MariaDB，将通过 MySQL 协议初始化 Guacamole 数据库。"
fi
