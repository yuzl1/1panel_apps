#!/bin/bash
# Generated from official installation evidence:
# - Apache Guacamole Docker docs: https://guacamole.apache.org/doc/gug/guacamole-docker.html
# - Guacamole requires an external MySQL or MariaDB service and schema initialization before first start.
# This package reuses an existing 1Panel MySQL or MariaDB app and initializes that database in-place.

set -eu

ENV_FILE="./.env"

if [[ ! -f "$ENV_FILE" ]]; then
  echo ".env 文件不存在"
  exit 1
fi

. "$ENV_FILE"

DB_SERVICE_NAME="${PANEL_DB_HOST_NAME:-${PANEL_DB_HOST:-}}"
if [[ -z "$DB_SERVICE_NAME" ]]; then
  echo "未找到 PANEL_DB_HOST 或 PANEL_DB_HOST_NAME，无法定位已存在的数据库服务。"
  exit 1
fi

MYSQL_CONTAINER=""
for candidate in "1panel-${DB_SERVICE_NAME}" "1Panel-${DB_SERVICE_NAME}" "${DB_SERVICE_NAME}"; do
  if docker ps -a --format '{{.Names}}' | grep -Fxq "$candidate"; then
    MYSQL_CONTAINER="$candidate"
    break
  fi
done

if [[ -z "$MYSQL_CONTAINER" ]]; then
  echo "未找到可用的 MySQL/MariaDB 容器，期望服务名为: ${DB_SERVICE_NAME}"
  exit 1
fi

if ! docker inspect -f '{{.State.Running}}' "$MYSQL_CONTAINER" 2>/dev/null | grep -Fxq "true"; then
  echo "数据库容器 ${MYSQL_CONTAINER} 当前未运行。"
  exit 1
fi

if [[ "${PANEL_DB_TYPE:-}" == "mariadb" ]]; then
  echo "当前选择的是 MariaDB，将通过 MySQL 协议初始化 Guacamole 数据库。"
fi

until docker exec -e MYSQL_PWD="${PANEL_DB_ROOT_PASSWORD}" "$MYSQL_CONTAINER" \
  mysqladmin -uroot --silent ping >/dev/null 2>&1; do
  echo "等待数据库容器 ${MYSQL_CONTAINER} 就绪..."
  sleep 3
done

docker exec -e MYSQL_PWD="${PANEL_DB_ROOT_PASSWORD}" "$MYSQL_CONTAINER" \
  mysql -uroot <<EOSQL
CREATE DATABASE IF NOT EXISTS \`${PANEL_DB_NAME}\` CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
CREATE USER IF NOT EXISTS '${PANEL_DB_USER}'@'%' IDENTIFIED BY '${PANEL_DB_USER_PASSWORD}';
ALTER USER '${PANEL_DB_USER}'@'%' IDENTIFIED BY '${PANEL_DB_USER_PASSWORD}';
GRANT ALL PRIVILEGES ON \`${PANEL_DB_NAME}\`.* TO '${PANEL_DB_USER}'@'%';
FLUSH PRIVILEGES;
EOSQL

if docker exec -e MYSQL_PWD="${PANEL_DB_ROOT_PASSWORD}" "$MYSQL_CONTAINER" \
  mysql -uroot -D"${PANEL_DB_NAME}" -Nse "SHOW TABLES LIKE 'guacamole_user';" | grep -q guacamole_user; then
  echo "Guacamole schema already exists in ${PANEL_DB_NAME}, skipping import."
  exit 0
fi

docker exec -i -e MYSQL_PWD="${PANEL_DB_ROOT_PASSWORD}" "$MYSQL_CONTAINER" \
  mysql -uroot "${PANEL_DB_NAME}" < ./scripts/initdb.sql

echo "Guacamole schema initialized successfully in existing database container ${MYSQL_CONTAINER}."
