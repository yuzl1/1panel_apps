## 产品介绍

**Apache Guacamole** 是一个无客户端远程桌面网关。用户只需要浏览器，就可以访问 RDP、VNC、SSH 等远程连接，不需要在本地安装额外客户端。

## 本地应用说明

这个目录已经整理为 **1Panel 自建应用** 结构，适合直接导入本地应用仓库使用：

- 使用 `guacamole/guacd` 官方镜像
- 数据库改为依赖 **1Panel 中已安装的 MySQL/MariaDB**
- 安装时会通过一次性初始化容器自动创建数据库、用户并导入 Guacamole schema

## 默认访问信息

- 访问端口：安装表单中的 `HTTP 端口`
- 默认账号：`guacadmin`
- 默认密码：`guacadmin`

首次登录后建议立即修改默认密码。
