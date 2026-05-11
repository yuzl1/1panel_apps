# App2Docker

一键将本地应用或运行环境转换为 Docker 镜像的可视化工具。

## 核心功能

* **可视化转换**：无需编写复杂的 Dockerfile，通过界面配置即可完成镜像构建。
* **快速部署**：支持将构建好的镜像直接推送到注册表或在本地运行。
* **轻量高效**：基于最新的封装技术，确保生成的镜像体积优化。

## 安装说明

1.  在 1Panel 应用商店中点击安装。
2.  配置服务端口（默认 8000）。
3.  确认挂载路径（默认使用应用目录下的 `data` 文件夹）。

## 注意事项

* **Docker 权限**：该应用需要访问宿主机的 `/var/run/docker.sock`，请确保运行环境具备相应权限。
* **存储**：所有转换过程中的临时文件和配置将保存在绑定的 `data` 目录中。

---

# App2Docker (English)

A visual tool to convert local applications or environments into Docker images with one click.

## Features

* **Visual Conversion**: Build Docker images via UI without writing Dockerfiles.
* **Fast Deployment**: Push built images to registries or run them locally.
* **Lightweight**: Optimized image size using modern packaging techniques.

## Installation

1.  Install via 1Panel App Store.
2.  Configure the service port (Default: 8000).
3.  Confirm the volume path (Default: `./data`).

## Notes

* **Docker Socket**: This app requires access to `/var/run/docker.sock`.
* **Storage**: All temporary files and configs are stored in the `./data` directory.
